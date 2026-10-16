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
        System.out.println("PASS: " + checks + " lifecycle/state checks; 500 registration/disconnect races");
    }
}
