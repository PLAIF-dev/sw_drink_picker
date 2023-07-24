import 'package:drink_picker/pick/actor/application/entity/pick_failure.dart';
import 'package:drink_picker/pick/actor/domain/repository/pick_repository.dart';
import 'package:drink_picker/pick/core/domain/value_object/exception.dart';
import 'package:fpdart/fpdart.dart';

abstract class PickService {
  Future<Either<PickFailure, Unit>> pick(int index);
}

class PickServiceImpl implements PickService {
  const PickServiceImpl(this._repository);

  final PickRepository _repository;

  @override
  Future<Either<PickFailure, Unit>> pick(int index) async {
    try {
      await _repository.pickAt(index);
      return right(unit);
    } on FailedCallException {
      return left(PickFailure.refused);
    }
  }
}
