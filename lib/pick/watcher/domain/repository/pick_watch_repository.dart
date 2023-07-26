import 'dart:async';

import 'package:drink_picker/pick/watcher/domain/value_object/machine_state.dart';

abstract class PickWatchRepository {
  Stream<MachineState> subscribe();
  FutureOr<void> unsubscribe();
}
