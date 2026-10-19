import cn.jiguang.uniplugin_jpush.helper.PendingEventDispatcher;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.atomic.AtomicInteger;

public class PendingEventDispatcherTest {
    private static int checks;

    private static void expect(List<String> actual, String... expected) {
        if (!actual.equals(Arrays.asList(expected))) throw new AssertionError(actual);
        checks++;
    }

    private static void await(CountDownLatch start) {
        try { start.await(); } catch (InterruptedException e) { throw new RuntimeException(e); }
    }

    public static void main(String[] args) throws Exception {
        Object first = new Object(), second = new Object();
        String[] types = {"NotificationEvent", "CustomMessageEvent", "InappMessageEvent",
                "LocalNotificationEvent", "TagAliasEvent", "MobileNumberEvent", "CommandEvent"};
        PendingEventDispatcher<String> all = new PendingEventDispatcher<>(100, null);
        for (String type : types) {
            all.publish(type, type + ":1");
            all.publish(type, type + ":2");
        }
        for (String type : types) {
            List<String> received = new ArrayList<>();
            all.register(type, first, value -> { received.add(value); return true; });
            expect(received, type + ":1", type + ":2");
            all.register(type, second, value -> { received.add(value); return true; });
            expect(received, type + ":1", type + ":2"); // No duplicate after re-registering.
            all.unregister(first); // Old module must not remove the replacement.
            all.publish(type, type + ":3");
            expect(received, type + ":1", type + ":2", type + ":3");
        }

        PendingEventDispatcher<String> isolated = new PendingEventDispatcher<>(100, null);
        List<String> remote = new ArrayList<>(), local = new ArrayList<>();
        isolated.publish("remote", "click-1");
        isolated.publish("local", "click-2");
        isolated.register("local", first, value -> { local.add(value); return true; });
        expect(remote);
        expect(local, "click-2");
        isolated.register("remote", first, value -> { remote.add(value); return true; });
        expect(remote, "click-1");
        isolated.unregister(first);
        isolated.publish("remote", "click-3");
        expect(remote, "click-1");
        isolated.register("remote", second, value -> { remote.add(value); return true; });
        expect(remote, "click-1", "click-3");

        PendingEventDispatcher<String> failed = new PendingEventDispatcher<>(100, null);
        failed.publish("result", "sequence-7:first-page");
        failed.publish("result", "sequence-7:second-page");
        failed.register("result", first, value -> false);
        List<String> recovered = new ArrayList<>();
        failed.register("result", second, value -> { recovered.add(value); return true; });
        expect(recovered, "sequence-7:first-page", "sequence-7:second-page");

        PendingEventDispatcher<String> throwing = new PendingEventDispatcher<>(100, null);
        throwing.publish("result", "keep-me");
        try {
            throwing.register("result", first, value -> { throw new IllegalStateException("bridge failure"); });
            throw new AssertionError("Expected callback failure");
        } catch (IllegalStateException expected) { checks++; }
        List<String> retried = new ArrayList<>();
        throwing.register("result", second, value -> { retried.add(value); return true; });
        expect(retried, "keep-me");

        PendingEventDispatcher<String> reentrant = new PendingEventDispatcher<>(100, null);
        List<String> order = new ArrayList<>();
        reentrant.register("event", first, value -> {
            order.add(value);
            if (value.equals("first")) {
                reentrant.register("event", second, next -> { order.add(next); return true; });
                reentrant.publish("event", "second");
            }
            return true;
        });
        reentrant.publish("event", "first");
        expect(order, "first", "second");

        AtomicInteger overflows = new AtomicInteger();
        PendingEventDispatcher<String> bounded = new PendingEventDispatcher<>(2, type -> overflows.incrementAndGet());
        bounded.publish("event", "old"); bounded.publish("event", "middle"); bounded.publish("event", "new");
        List<String> boundedEvents = new ArrayList<>();
        bounded.register("event", first, value -> { boundedEvents.add(value); return true; });
        expect(boundedEvents, "middle", "new");
        if (overflows.get() != 1) throw new AssertionError(overflows);
        checks++;

        PendingEventDispatcher<String> inFlight = new PendingEventDispatcher<>(1, type -> overflows.incrementAndGet());
        List<String> one = new ArrayList<>();
        inFlight.register("event", first, value -> {
            one.add(value);
            inFlight.publish("event", "cannot-evict-in-flight");
            return true;
        });
        inFlight.publish("event", "in-flight");
        expect(one, "in-flight");
        if (overflows.get() != 2) throw new AssertionError(overflows);
        checks++;

        PendingEventDispatcher<String> nested = new PendingEventDispatcher<>(2, null);
        nested.publish("event", "in-flight"); nested.publish("event", "old-waiting");
        List<String> nestedEvents = new ArrayList<>();
        nested.register("event", first, value -> {
            nestedEvents.add(value);
            if (value.equals("in-flight")) nested.publish("event", "new-waiting");
            return true;
        });
        expect(nestedEvents, "in-flight", "new-waiting");

        PendingEventDispatcher<String> brokenDiagnostics = new PendingEventDispatcher<>(100, null, message -> {
            throw new IllegalStateException("diagnostic failure");
        });
        List<String> unaffected = new ArrayList<>();
        brokenDiagnostics.publish("event", "before");
        brokenDiagnostics.register("event", first, value -> { unaffected.add(value); return true; });
        brokenDiagnostics.unregister(second);
        brokenDiagnostics.publish("event", "after");
        expect(unaffected, "before", "after");

        for (int round = 0; round < 200; round++) {
            PendingEventDispatcher<Integer> concurrent = new PendingEventDispatcher<>(100, null);
            List<Integer> values = new ArrayList<>();
            CountDownLatch start = new CountDownLatch(1);
            Thread producer = new Thread(() -> {
                await(start);
                for (int value = 0; value < 50; value++) concurrent.publish("event", value);
            });
            Thread consumer = new Thread(() -> {
                await(start);
                concurrent.register("event", first, value -> { values.add(value); return true; });
                concurrent.unregister(first);
                concurrent.register("event", second, value -> { values.add(value); return true; });
                concurrent.unregister(first);
            });
            producer.start(); consumer.start(); start.countDown();
            producer.join(); consumer.join();
            if (values.size() != 50) throw new AssertionError(values);
            for (int value = 0; value < 50; value++) {
                if (values.get(value) != value) throw new AssertionError(values);
            }
        }
        System.out.println("PASS: " + checks + " queue/lifecycle/failure checks; 200 producer/registration races (10000 events)");
    }
}
