import 'dart:async';

abstract class CommunicationChannel {
  bool get isInitialized;
  Future<void> initialize(Uri uri);
  FutureOr<void> dispose();
  Future<void> send(String message);
  Future<dynamic> fetch(String message);
  Stream<dynamic> listen(String message);
}
