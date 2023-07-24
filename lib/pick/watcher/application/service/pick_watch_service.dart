import 'package:drink_picker/pick/watcher/application/entity/pick_watch_failure.dart';
import 'package:drink_picker/pick/watcher/domain/repository/pick_watch_repository.dart';
import 'package:drink_picker/pick/watcher/domain/value_object/exception.dart';
import 'package:drink_picker/pick/watcher/domain/value_object/machine_io_state.dart';
import 'package:fpdart/fpdart.dart';

abstract class PickWatchService {
  Stream<Either<PickWatchFailure, MachineIoState>> watchState();
}

class PickWatchServiceImpl implements PickWatchService {
  const PickWatchServiceImpl(this._repository);

  final PickWatchRepository _repository;

  @override
  Stream<Either<PickWatchFailure, MachineIoState>> watchState() async* {
    try {
      yield* _repository.listenState().map((value) => right(value));
    } on InvalidPickWatchException {
      yield left(PickWatchFailure.refused);
    }
  }
}
