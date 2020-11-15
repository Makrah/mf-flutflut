import 'dart:async';

class DisposableWidget {
  final List<StreamSubscription<dynamic>> _subscriptions = <StreamSubscription<dynamic>>[];

  void cancelSubscriptions() {
    for (final StreamSubscription<dynamic> subscription in _subscriptions) {
      subscription.cancel();
    }
  }

  void addSubscription(StreamSubscription<dynamic> subscription) {
    _subscriptions.add(subscription);
  }
}

extension DisposableStreamSubscriton on StreamSubscription<dynamic> {
  void canceledBy(DisposableWidget widget) {
    widget.addSubscription(this);
  }
}
