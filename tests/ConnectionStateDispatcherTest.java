import cn.jiguang.uniplugin_jpush.helper.ConnectionStateDispatcher;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.CountDownLatch;

public class ConnectionStateDispatcherTest {
    private static int checks;

    private static void expect(List<Boolean> actual, Boolean... expected) {
        if (!actual.equals(Arrays.asList(expected))) throw new AssertionError(actual);
        checks++;
    }

    public static void main(String[] args) throws Exception {
        Object first = new Object(), second = new Object();
        List<Boolean> events = new ArrayList<>();
        ConnectionStateDispatcher state = new ConnectionStateDispatcher();
        state.register(first, events::add);
        expect(events); // Unknown must not fabricate a disconnected event.
        state.update(true);
        state.update(false);
        expect(events, true, false);
        state.unregister(first);
        state.update(true);
        expect(events, true, false);
        state.register(second, events::add);
        expect(events, true, false, true); // JS re-created in the same process.
        state.unregister(first); // Old module destruction cannot detach the new one.
        state.update(false);
        expect(events, true, false, true, false);

        ConnectionStateDispatcher early = new ConnectionStateDispatcher();
        early.update(true);
        early.update(false);
        List<Boolean> late = new ArrayList<>();
        early.register(first, late::add);
        expect(late, false); // Only replay the latest real state.
        new ConnectionStateDispatcher().register(first, late::add);
        expect(late, false); // Simulated new process has no cached online state.

        ConnectionStateDispatcher snapshot = new ConnectionStateDispatcher();
        List<Boolean> snapshots = new ArrayList<>();
        snapshot.register(first, snapshots::add);
        if (snapshot.hasState()) throw new AssertionError("Unknown state became known without SDK data");
        expect(snapshots);
        snapshot.initializeIfUnknown(true);
        expect(snapshots, true);
        snapshot.update(false);
        snapshot.initializeIfUnknown(true);
        expect(snapshots, true, false);

        for (int run = 0; run < 500; run++) {
            ConnectionStateDispatcher race = new ConnectionStateDispatcher();
            race.update(true);
            List<Boolean> received = new ArrayList<>();
            CountDownLatch start = new CountDownLatch(1);
            Thread register = new Thread(() -> {
                try { start.await(); } catch (InterruptedException e) { throw new RuntimeException(e); }
                race.register(first, received::add);
            });
            Thread disconnect = new Thread(() -> {
                try { start.await(); } catch (InterruptedException e) { throw new RuntimeException(e); }
                race.update(false);
            });
            register.start(); disconnect.start(); start.countDown();
            register.join(); disconnect.join();
            if (received.isEmpty() || received.get(received.size() - 1)) {
                throw new AssertionError("Stale replay after disconnect: " + received);
            }
        }
        for (int run = 0; run < 200; run++) {
            ConnectionStateDispatcher race = new ConnectionStateDispatcher();
            List<Boolean> received = new ArrayList<>();
            race.register(first, received::add);
            CountDownLatch start = new CountDownLatch(1);
            Thread query = new Thread(() -> {
                try { start.await(); } catch (InterruptedException e) { throw new RuntimeException(e); }
                race.initializeIfUnknown(true);
            });
            Thread sdk = new Thread(() -> {
                try { start.await(); } catch (InterruptedException e) { throw new RuntimeException(e); }
                race.update(false);
            });
            query.start(); sdk.start(); start.countDown(); query.join(); sdk.join();
            if (received.isEmpty() || received.get(received.size() - 1)) {
                throw new AssertionError("Initial query overwrote SDK callback: " + received);
            }
        }
        System.out.println("PASS: " + checks + " lifecycle/state checks; 500 registration/disconnect races; 200 initial-query/SDK-event races");
    }
}
