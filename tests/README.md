# Android 事件回调回归

在仓库根目录运行以下命令（需要 JDK 和 Node.js）：

```sh
mkdir -p tests/build
javac -d tests/build \
  UniPlugin-JPush-Android/uniplugin_jpush/src/main/java/cn/jiguang/uniplugin_jpush/helper/ConnectionStateDispatcher.java \
  UniPlugin-JPush-Android/uniplugin_jpush/src/main/java/cn/jiguang/uniplugin_jpush/helper/PendingEventDispatcher.java \
  tests/ConnectionStateDispatcherTest.java tests/PendingEventDispatcherTest.java
java -cp tests/build ConnectionStateDispatcherTest
java -cp tests/build PendingEventDispatcherTest
node tests/connection-page.test.mjs
```

覆盖连接状态补发、7类普通事件队列、类型隔离、顺序、失败保留、重复登记、实例销毁、重入、容量上限、并发，以及Demo所有监听早于初始化、页面状态/RID同步。

这些检查不调用远端推送服务，不代替Android设备上的SDK接收器、JS桥接和厂商通道验证。
