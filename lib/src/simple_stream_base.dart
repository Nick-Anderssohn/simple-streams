// Copyright (C) 2017  Nicholas Anderssohn
import "dart:async";

abstract class SimpleStreamBase {
  List<StreamSubscription> subs = new List<StreamSubscription>();

  StreamSubscription listen(handler(var e));

  //cancels all stream subscriptions
  cancelAll() {
    subs.forEach((var sub) => sub.cancel());
    subs.clear();
  }

  // cancels the sub that was passed in, given that it is from this stream
  cancelSub(StreamSubscription sub) {
    if (subs.contains(sub)) {
      sub.cancel();
      subs.remove(sub);
    }
  }
}
