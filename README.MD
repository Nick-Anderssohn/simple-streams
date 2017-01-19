Simple streams is designed for people who have little experience with streams.
Its goal is to help avoid memory leaks and keep code clean at the same time.

Should be used for event streams (i.e. you wanted to make your own onClick or something similar).
Not meant for other streaming purposes.

Source code: https://github.com/Nick-Anderssohn/simple-streams
Example in test folder

Example usage:

class Test {
  SimpleStream _testStream = new SimpleStream();

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
