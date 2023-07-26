import 'dart:math' as math;
import 'package:drink_picker/pick/actor/domain/repository/pick_repository.dart';
import 'package:drink_picker/pick/watcher/infrastructure/repository/pick_watch_repository_fake_impl.dart';

class PickRepositoryFakeImpl implements PickRepository {
  const PickRepositoryFakeImpl(this._fakeRepository);

  final PickWatchRepositoryFakeImpl _fakeRepository;

  @override
  Future<void> pickAt(int index) async {
    _fakeRepository.makeItBusy(index);
    Future.delayed(
      const Duration(seconds: 6),
      () {
        final errorProbability = math.Random().nextDouble();
        if (errorProbability > 0.8) {
          _fakeRepository.makeItBlocked();
        } else {
          _fakeRepository.makeItEmpty();
        }
      },
    );
  }
}
