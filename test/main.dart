import '../lib/simple_streams.dart';
import 'dart:html';

class Test {
  SimpleStream _testStream = new SimpleStream();
  SimpleStreamRouter _router;
  int numFired = 0;

  Test() {
    _router = new SimpleStreamRouter(querySelector('#btn-test').onClick);
    _router.listen(fire);
    querySelector('#btn-test').text = "click me to fire event.";
  }
  //equivalent to onFire.listen() if onFire was of type Stream
  onFire(handler(var e)) {
    return _testStream.listen(handler);
  }

  //calls simples streams cancelAll func
  //call this when done with the stream (often in the onBeforeUnload handler for example)
  cancelAllFireSubs() {
    _testStream.cancelAll();
    _router.cancelAll();
  }

  fire(var e) {
    //equivalent of calling add on a StreamController that was initialized with .broadcast()
    numFired++;
    _testStream.add('click me to fire event. Events fired: $numFired');
  }
}

main() {
  Test test = new Test();
  test.onFire(handler);

  // DONT USE: querySelector('#test-div').onClick.listen((var e) => test.fire());
  // Use SimpleStreamRouter instead...see the constructor of the Test class

  //querySelector('#btn-cancel').onClick.listen((var e) => test.cancelAllFireSubs()); // use SimpleStreamRouter instead

  SimpleStreamRouter cancelRouter =
      new SimpleStreamRouter(querySelector('#btn-cancel').onClick);

  cancelHandler(var e) {
    test.cancelAllFireSubs();
    cancelRouter.cancelAll();
  }

  // The call below is equivalent to
  // querySelector('#btn-cancel').onClick.listen(cancelHandler)
  // except that the router will automatically keep track of StreamSubscriptions for you
  cancelRouter.listen(cancelHandler);

  //this will often be where you want to call cancelAll...helps avoid memory leaks...
  window.onBeforeUnload.listen(cancelHandler);
}

handler(var e) {
  querySelector('#btn-test').text = e;
}
