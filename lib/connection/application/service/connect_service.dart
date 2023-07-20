import 'dart:async';

import 'package:drink_picker/connection/application/entity/connect_failure.dart';
import 'package:drink_picker/connection/domain/repository/connection_repository.dart';
import 'package:drink_picker/connection/domain/value_object/exception.dart';
import 'package:fpdart/fpdart.dart';

abstract class ConnectService {
  Future<Either<ConnectFailure, Unit>> connect(Uri uri);
  FutureOr<void> disconnect();
}

class ConnectServiceImpl implements ConnectService {
  const ConnectServiceImpl(this._repository);

  final ConnectionRepository _repository;

  @override
  Future<Either<ConnectFailure, Unit>> connect(Uri uri) async {
    try {
      await _repository.connect(uri);
      return right(unit);
    } on InvalidConnectionException {
      return left(ConnectFailure.invalid);
    }
  }

  @override
  FutureOr<void> disconnect() async {
    await _repository.disconnect();
  }
}
