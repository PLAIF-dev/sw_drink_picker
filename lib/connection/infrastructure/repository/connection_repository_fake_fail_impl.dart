import 'package:drink_picker/connection/domain/repository/connection_repository.dart';
import 'package:drink_picker/connection/domain/value_object/exception.dart';

class ConnectionRepositoryFakeFailImpl implements ConnectionRepository {
  @override
  Future<void> connect(Uri uri) {
    throw const InvalidConnectionException();
  }

  @override
  Future<void> disconnect() async {
    return;
  }
}
