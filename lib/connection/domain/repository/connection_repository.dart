abstract class ConnectionRepository {
  Future<void> connect(Uri uri);
  Future<void> disconnect();
}
