library simple_stream;

import "dart:async";

class SimpleStream {
  StreamController _streamer = new StreamController.broadcast();
  Stream get _stream => _streamer.stream;
  List<StreamSubscription> subs = new List<StreamSubscription>();

  SimpleStream() {}

  StreamSubscription listen(handler(var e)) {
    subs.add(_stream.listen(handler));
    return subs.last;
  }

  //cancels all stream subscriptions
  //call this when done with the stream (often in the onBeforeUnload.listen handler for example)
  cancelAll() {
    for (StreamSubscription f in subs) {
      f.cancel();
    }
  }

//equivalent to streamcontrollers add func
//use to add an event to the stream
  add(var event) {
    _streamer.add(event);
  }
}
