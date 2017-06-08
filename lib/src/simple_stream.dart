// Copyright (C) 2017  Nicholas Anderssohn

import "dart:async";
import 'simple_stream_base.dart';

class SimpleStream extends SimpleStreamBase {
  StreamController _streamer = new StreamController.broadcast();
  Stream get _stream => _streamer.stream;
  List<StreamSubscription> subs = new List<StreamSubscription>();

  SimpleStream();

  StreamSubscription listen(handler(var e)) {
    subs.add(_stream.listen(handler));
    return subs.last;
  }

  //equivalent to streamcontroller's add func
  //use to add an event to the stream
  add(var event) {
    _streamer.add(event);
  }
}
