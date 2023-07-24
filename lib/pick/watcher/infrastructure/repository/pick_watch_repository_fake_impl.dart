import 'package:drink_picker/pick/watcher/domain/repository/pick_watch_repository.dart';
import 'package:drink_picker/pick/watcher/domain/value_object/machine_io_state.dart';

class PickWatchRepositoryFakeImpl implements PickWatchRepository {
  const PickWatchRepositoryFakeImpl();
  @override
  Stream<MachineIoState> listenState() {
    return Stream.periodic(
      const Duration(seconds: 3),
      (index) {
        if (index % 2 == 1) {
          return const MachineIoState.empty();
        } else {
          return MachineIoState.busy(index);
        }
      },
    );
  }
}
