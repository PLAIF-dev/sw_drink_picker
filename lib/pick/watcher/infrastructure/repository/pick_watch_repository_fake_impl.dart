import 'dart:async';

import 'package:drink_picker/pick/watcher/domain/repository/pick_watch_repository.dart';
import 'package:drink_picker/pick/watcher/domain/value_object/machine_io_state.dart';

class PickWatchRepositoryFakeImpl implements PickWatchRepository {
  PickWatchRepositoryFakeImpl();

  late StreamController<MachineIoState> _controller;

  @override
  Stream<MachineIoState> subscribe() {
    Timer? timer;
    int counter = 0;

    void tick(Timer _) {
      counter++;
      if (counter % 2 == 1) {
        _controller.add(const MachineIoState.empty());
      } else {
        _controller.add(MachineIoState.busy(counter % 2));
      }
    }

    void startTimer() {
      timer = Timer.periodic(const Duration(seconds: 2), tick);
    }

    void stopTimer() {
      timer?.cancel();
      timer = null;
    }

    _controller = StreamController<MachineIoState>(
      onListen: startTimer,
      onPause: stopTimer,
      onResume: startTimer,
      onCancel: stopTimer,
    );

    return _controller.stream;
  }

  @override
  FutureOr<void> unsubscribe() {
    _controller.close();
  }
}
