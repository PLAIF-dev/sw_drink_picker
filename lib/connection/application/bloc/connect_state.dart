import 'package:drink_picker/connection/application/entity/connect_failure.dart';

abstract class ConnectState {
  const factory ConnectState.none() = ConnectNoneState._;
  const factory ConnectState.wired() = ConnectWiredState._;
  const factory ConnectState.failed(ConnectFailure failure) =
      ConnectFailedState._;

  String get message;
}

class ConnectNoneState implements ConnectState {
  const ConnectNoneState._();

  @override
  String get message => 'Connection Closed';
}

class ConnectWiredState implements ConnectState {
  const ConnectWiredState._();

  @override
  String get message => 'Connection Started';
}

class ConnectFailedState implements ConnectState {
  const ConnectFailedState._(this.failure);

  final ConnectFailure failure;

  @override
  String get message => 'Fail: ${failure.name}';
}
