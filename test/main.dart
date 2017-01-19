import '../lib/simple_stream.dart';
import 'dart:html';

class Test {
  SimpleStream _testStream = new SimpleStream();

  Test() {}
  onFire(handler(var e)) {
    return _testStream.listen(handler);
  }

  //calls simples streams cancelAll func
  //call this when done with the stream (often in the onBeforeUnload handler for example)
  cancelAllFireSubs() {
    _testStream.cancelAll();
  }

  fire() {
    _testStream.add('example event fired');
  }
}

main() {
  Test test = new Test();
  test.onFire(handler); //this is the equivalent of doing onSomeEvent.listen() for a normal dart Stream
  test.fire();

  //this will often be where you want to call cancelAll...helps avoid memory leaks...
  window.onBeforeUnload.listen((var e) {
    test.cancelAllFireSubs();
  });
}

handler(var e) {
querySelector('#test-div').text = e;
}
