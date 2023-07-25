import 'dart:async';

import 'package:drink_picker/pick/watcher/application/entity/pick_watch_failure.dart';
import 'package:drink_picker/pick/watcher/domain/repository/pick_watch_repository.dart';
import 'package:drink_picker/pick/watcher/domain/value_object/exception.dart';
import 'package:drink_picker/pick/watcher/domain/value_object/machine_io_state.dart';
import 'package:fpdart/fpdart.dart';

abstract class PickWatchService {
  Stream<Either<PickWatchFailure, MachineIoState>> subscribeState();
  FutureOr<Either<PickWatchFailure, Unit>> unsubscribe();
}

class PickWatchServiceImpl implements PickWatchService {
  const PickWatchServiceImpl(this._repository);

  final PickWatchRepository _repository;

  @override
  Stream<Either<PickWatchFailure, MachineIoState>> subscribeState() async* {
    try {
      yield* _repository.subscribe().map((value) => right(value));
    } on InvalidPickWatchException {
      yield left(PickWatchFailure.refused);
    }
  }

  @override
  FutureOr<Either<PickWatchFailure, Unit>> unsubscribe() async {
    // TODO: catch edge cases for failure
    await _repository.unsubscribe();
    return right(unit);
  }
}
