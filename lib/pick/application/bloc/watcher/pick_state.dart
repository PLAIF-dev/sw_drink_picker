import 'package:drink_picker/pick/application/entity/pick_failure.dart';

abstract class PickState {
  const factory PickState.idle() = PickIdleState._;
  const factory PickState.picking() = PickPickingState._;
  const factory PickState.failed(PickFailure failure) = PickFailedState._;

  String get message;
}

class PickIdleState implements PickState {
  const PickIdleState._();

  @override
  String get message => 'Nothing to do';
}

class PickPickingState implements PickState {
  const PickPickingState._();

  @override
  String get message => 'Picking...';
}

class PickFailedState implements PickState {
  const PickFailedState._(this.failure);

  final PickFailure failure;

  @override
  String get message => 'Fail: ${failure.message}';
}
