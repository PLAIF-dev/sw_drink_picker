import 'package:drink_picker/connection/domain/repository/connection_repository.dart';
import 'package:drink_picker/connection/domain/value_object/exception.dart';
import 'package:drink_picker/connection/infrastructure/datastore/communication_channel.dart';

class ConnectionRepositoryImpl implements ConnectionRepository {
  const ConnectionRepositoryImpl(this._channel);

  final CommunicationChannel _channel;

  @override
  Future<void> connect(Uri uri) {
    try {
      return _channel.initialize(uri);
    } on InvalidConnectionException {
      rethrow;
    }
  }

  @override
  Future<void> disconnect() async {
    return _channel.dispose();
  }
}
