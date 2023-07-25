import 'dart:async';
import 'dart:convert';

import 'package:drink_picker/connection/infrastructure/datastore/communication_channel.dart';
import 'package:drink_picker/core/infrastructure/entity/request.dart';
import 'package:drink_picker/pick/watcher/domain/repository/pick_watch_repository.dart';
import 'package:drink_picker/pick/watcher/domain/value_object/machine_io_state.dart';

class PickWatchRepositoryImpl implements PickWatchRepository {
  PickWatchRepositoryImpl(this._channel);

  final CommunicationChannel _channel;
  late StreamController<MachineIoState> _controller;
  bool? _hasBeenWorking;

  @override
  Stream<MachineIoState> subscribe() {
    try {
      _controller = StreamController(
        onCancel: () => _controller.close(),
      );

      const request = Request(
        op: "subscribe",
        topic: "/ur_hardware_interface/io_states",
        type: "ur_msgs/IOStates",
      );

      final result = _channel.listen(request.encode());

      late StreamSubscription subscription;
      subscription = result.listen(
        (value) {
          final inStates =
              json.decode(value)['msg']['digital_in_states'] as List<dynamic>;

          /// Business Rule: `digital io 5번 pin` 이 로봇 작업 중인지 아닌지 판단하는 flag
          /// ```json
          /// {
          ///   'state': true,
          ///   'pin': 5
          /// }
          /// ```
          final isWorking = inStates.removeAt(5)['state'] as bool;

          if (isWorking == _hasBeenWorking) {
            return;
          }

          _hasBeenWorking = isWorking;

          MachineIoState ioState;

          if (isWorking) {
            final index =
                inStates.indexWhere((inState) => inState['state'] as bool);

            if (index < 0) {
              ioState = MachineIoState.busy(index);
            } else {
              ioState = const MachineIoState.empty();
            }
          } else {
            ioState = const MachineIoState.empty();
          }

          _controller.add(ioState);
        },
        onDone: () {
          subscription.cancel();
          _controller.close();
        },
        onError: (_) {
          subscription.cancel();
          _controller.close();
        },
      );

      return _controller.stream.asBroadcastStream();
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  FutureOr<void> unsubscribe() async {
    _controller.close();
  }
}
