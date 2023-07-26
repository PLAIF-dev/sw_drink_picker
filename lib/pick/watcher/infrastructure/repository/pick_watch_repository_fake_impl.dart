import 'dart:async';

import 'package:drink_picker/pick/watcher/domain/repository/pick_watch_repository.dart';
import 'package:drink_picker/pick/watcher/domain/value_object/machine_state.dart';

class PickWatchRepositoryFakeImpl implements PickWatchRepository {
  PickWatchRepositoryFakeImpl();

  late StreamController<MachineState>? _controller;

  int _workingIndex = 0;

  @override
  Stream<MachineState> subscribe() {
    _controller = StreamController<MachineState>(
      onCancel: () => _controller?.close(),
    );

    Future.delayed(
      const Duration(milliseconds: 1200),
      () {
        _controller!.add(const MachineState.empty());
      },
    );

    return _controller!.stream;
  }

  @override
  FutureOr<void> unsubscribe() {
    _controller?.close();
    _controller = null;
  }

  void makeItBusy(int index) {
    _workingIndex = index;
    _controller!.add(MachineState.busy(index));
  }

  void makeItBlocked() {
    _controller!.add(MachineState.blocked(_workingIndex));
  }

  void makeItEmpty() {
    _controller!.add(const MachineState.empty());
  }
}
