import 'package:drink_picker/connection/domain/repository/connection_repository.dart';

class ConnectionRepositoryFakeSuccessImpl implements ConnectionRepository {
  const ConnectionRepositoryFakeSuccessImpl();

  @override
  Future<void> connect(Uri uri) async {
    return;
  }

  @override
  Future<void> disconnect() async {
    return;
  }
}
