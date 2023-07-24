import 'package:drink_picker/pick/watcher/application/entity/pick_watch_failure.dart';

abstract class PickWatchState {
  const factory PickWatchState.ready() = PickWatchReadyState._;
  const factory PickWatchState.busy(int workingIndex) = PickWatchBusyState._;
  const factory PickWatchState.failed(PickWatchFailure failure) =
      PickWatchFailedState._;

  String get message;
}

class PickWatchReadyState implements PickWatchState {
  const PickWatchReadyState._();

  @override
  String get message => 'Ready to send request';
}

class PickWatchBusyState implements PickWatchState {
  const PickWatchBusyState._(this.workingIndex);

  final int workingIndex;

  @override
  String get message => 'Ready to send request';
}

class PickWatchFailedState implements PickWatchState {
  const PickWatchFailedState._(this.failure);

  final PickWatchFailure failure;

  @override
  String get message => failure.message;
}
