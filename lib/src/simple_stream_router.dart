// Copyright (C) 2017  Nicholas Anderssohn
import 'simple_stream_base.dart';
import 'dart:async';

// A simple stream that forwards an existing stream's events rather than creating its own
class SimpleStreamRouter extends SimpleStreamBase {
  Stream _stream;

  SimpleStreamRouter(Stream stream) {
    _stream = stream;
  }

  StreamSubscription listen(handler(var e)) {
    subs.add(_stream.listen(handler));
    return subs.last;
  }
}
