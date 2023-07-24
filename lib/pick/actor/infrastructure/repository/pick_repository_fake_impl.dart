import 'package:drink_picker/pick/actor/domain/repository/pick_repository.dart';

class PickRepositoryFakeImpl implements PickRepository {
  const PickRepositoryFakeImpl();
  @override
  Future<void> pickAt(int index) async {
    return;
  }
}
