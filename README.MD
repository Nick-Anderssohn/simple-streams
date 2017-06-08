# Simple Streams
Normal broadcast streams can be a pain. You have to keep track of all stream subscriptions manually, or there can be memory leaks. simple_streams makes it easier by keeping track of those subscriptions for you. Let's look at the standard dart way of using a broadcast stream versus with simple_streams.

---

## Standard Dart Method (Bad)

First you must create a new broadcast StreamController and keep track of it's stream.

```
StreamController exampleStreamController = new StreamController.broadcast();
Stream exampleStream = exampleStreamController.stream;
```

Next, whenever you add a listener to the stream, you must manually keep track of the subscription.

```
exampleHandler(var e) {
  print('test');
}
StreamSubscription sub = exampleStream.listen(exampleHandler);
```

Finally, you must cancel the subscription when you are done with the stream.  If you do not, you will get a memory leak.

```
sub.cancel();
```

Everytime you call .listen on that stream, it will create another StreamSubscription. You must keep track of all StreamSubscriptions and cancel all of them, otherwise you will create a memory leak. Or you can use simple streams to make it easier ;)

## Simple Streams Method

Instead of creating a stream controller (and probably a separate variable to hold its stream), just create a simple stream.

```
SimpleStream exampleStream = new SimpleStream();
```

Next, you can add listeners as many times as you want without keeping track of their subscriptions.

```
exampleHandler(var e) {
  print('test');
}
exampleStream.listen(exampleHandler);
```

Later, when you are done with the stream and it is going to be destroyed, call cancelAll() and it will cancel all of those subscriptions for you.

```
exampleStream.cancelAll();
```

---

## SimpleStreamRouter

With version 1.1.0 of simple streams, a new class was introduced, SimpleStreamRouter. SimpleStreamRouter is just a wrapper that can be used with any pre-existing stream. For example, you may use it with a DivElement's onClick stream. It will do the same thing as a SimpleStream and keep track of the StreamSubscriptions for you.

```
SimpleStreamRouter router = new SimpleStreamRouter(querySelector('#example-element').onClick);

```

Listen to the router without keeping track of StreamSubscriptions. You will receive the same Event by listening to the router as you would to the element's stream itself.

```
exampleHandler(MouseEvent e) {
  print("do something");
}
router.listen(exampleHandler);
```

When you are done with the router, you can call cancelAll() to avoid memory leaks.

```
router.cancelAll()
```

Source code: https://github.com/Nick-Anderssohn/simple-streams

See the example in the test folder.

How to install: https://pub.dartlang.org/packages/simple_streams
