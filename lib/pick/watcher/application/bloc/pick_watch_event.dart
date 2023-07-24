import 'package:drink_picker/pick/watcher/application/bloc/pick_watch_state_notifier.dart';

abstract class PickWatchEvent {
  const factory PickWatchEvent.watchIoChanges() = PickWatchWatchEvent._;

  void handle(PickWatchStateNotifier context);
}

class PickWatchWatchEvent implements PickWatchEvent {
  const PickWatchWatchEvent._();

  @override
  void handle(PickWatchStateNotifier context) {
    context.listenRemoteChanges();
  }
}
