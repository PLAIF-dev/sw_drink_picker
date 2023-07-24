import 'package:drink_picker/pick/watcher/domain/value_object/machine_io_state.dart';

abstract class PickWatchRepository {
  Stream<MachineIoState> listenState();
}
