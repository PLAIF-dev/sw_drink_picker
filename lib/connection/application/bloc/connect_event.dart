import 'package:drink_picker/connection/application/bloc/connect_state_notifier.dart';

abstract class ConnectEvent {
  const factory ConnectEvent.connect(Uri uri) = ConnectionConnectEvent._;
  const factory ConnectEvent.disconnect() = ConnectionDisconnectEvent._;

  void handle(ConnectStateNotifier context);
}

class ConnectionConnectEvent implements ConnectEvent {
  const ConnectionConnectEvent._(this.uri);

  final Uri uri;

  @override
  void handle(ConnectStateNotifier context) {
    context.connect(uri);
  }
}

class ConnectionDisconnectEvent implements ConnectEvent {
  const ConnectionDisconnectEvent._();

  @override
  void handle(ConnectStateNotifier context) {
    context.disconnect();
  }
}
