import 'package:drink_picker/pick/watcher/application/bloc/pick_watch_state_notifier.dart';

abstract class PickWatchEvent {
  const factory PickWatchEvent.subscribeChanges() = PickWatchSubscribeEvent._;
  const factory PickWatchEvent.unsubscribe() = PickWatchUnsubscribeEvent._;

  void handle(PickWatchStateNotifier context);
}

class PickWatchSubscribeEvent implements PickWatchEvent {
  const PickWatchSubscribeEvent._();

  @override
  void handle(PickWatchStateNotifier context) {
    context.subscribe();
  }
}

class PickWatchUnsubscribeEvent implements PickWatchEvent {
  const PickWatchUnsubscribeEvent._();

  @override
  void handle(PickWatchStateNotifier context) {
    context.unsubscribe();
  }
}
