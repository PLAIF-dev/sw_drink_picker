import 'dart:async';
import 'dart:io';
import 'package:drink_picker/connection/domain/value_object/exception.dart';
import 'package:drink_picker/connection/infrastructure/datastore/communication_channel.dart';

class WebsocketCommunicationChannel implements CommunicationChannel {
  WebSocket? _socket;

  @override
  bool get isInitialized => _socket != null;

  @override
  Future<void> initialize(Uri uri) async {
    try {
      _socket = await WebSocket.connect(uri.toString());
    } on SocketException {
      throw const InvalidConnectionException();
    }
  }

  @override
  FutureOr<void> dispose() {
    _socket?.close();
    _socket = null;
  }

  @override
  Future<void> send(String message) async {
    _communicate(message);
  }

  @override
  Future<dynamic> fetch(String message) async {
    return _communicate(message).first;
  }

  @override
  Stream<dynamic> listen(String message) {
    return _communicate(message);
  }

  Stream<dynamic> _communicate(String message) {
    if (!isInitialized) throw const NoConnectionException();

    _socket!.add(message);

    return _socket!.asBroadcastStream();
  }
}
