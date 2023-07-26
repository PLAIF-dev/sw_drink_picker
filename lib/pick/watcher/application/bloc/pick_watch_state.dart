import 'package:drink_picker/pick/watcher/application/entity/pick_watch_failure.dart';

abstract class PickWatchState {
  const factory PickWatchState.none() = PickWatchNoneState._;
  const factory PickWatchState.ready() = PickWatchReadyState._;
  const factory PickWatchState.busy(int workingIndex) = PickWatchBusyState._;
  const factory PickWatchState.blocked(int holdingIndex) =
      PickWatchBlockedState._;
  const factory PickWatchState.failed(PickWatchFailure failure) =
      PickWatchFailedState._;

  String get message;
}

class PickWatchNoneState implements PickWatchState {
  const PickWatchNoneState._();

  @override
  String get message => 'None';
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
  String get message => 'Working';
}

class PickWatchBlockedState implements PickWatchState {
  const PickWatchBlockedState._(this.holdingIndex);

  final int holdingIndex;

  @override
  String get message => 'Process is blocked';
}

class PickWatchFailedState implements PickWatchState {
  const PickWatchFailedState._(this.failure);

  final PickWatchFailure failure;

  @override
  String get message => failure.message;
}
