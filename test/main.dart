import '../lib/simple_streams.dart';
import 'dart:html';

class Test {
  SimpleStream _testStream = new SimpleStream();
  int numFired = 0;
  Test() {}
  //equivalent to onFire.listen() if onFire was of type Stream
  onFire(handler(var e)) {
    return _testStream.listen(handler);
  }

  //calls simples streams cancelAll func
  //call this when done with the stream (often in the onBeforeUnload handler for example)
  cancelAllFireSubs() {
    _testStream.cancelAll();
  }

  fire() {
    //equivalent of calling add on a StreamController that was initialized with .broadcast()
    numFired++;
    _testStream.add('click me to fire event. Events fired: $numFired');
  }
}

main() {
  Test test = new Test();
  test.onFire(handler); //this is the equivalent of doing onSomeEvent.listen() for a normal dart Stream
  querySelector('#test-div').onClick.listen((var e) => test.fire());
  querySelector('#test-div').text = "click me to fire event.";
  querySelector('#btn-cancel').onClick.listen((var e) => test.cancelAllFireSubs());

  //this will often be where you want to call cancelAll...helps avoid memory leaks...
  window.onBeforeUnload.listen((var e) {
    test.cancelAllFireSubs();
  });
}

handler(var e) {
querySelector('#test-div').text = e;
}
