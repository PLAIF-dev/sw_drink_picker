import 'dart:async';
import 'dart:convert';

import 'package:drink_picker/connection/infrastructure/datastore/communication_channel.dart';
import 'package:drink_picker/core/infrastructure/entity/request.dart';
import 'package:drink_picker/pick/watcher/domain/repository/pick_watch_repository.dart';
import 'package:drink_picker/pick/watcher/domain/value_object/machine_state.dart';

class PickWatchRepositoryImpl implements PickWatchRepository {
  PickWatchRepositoryImpl(this._channel);

  final CommunicationChannel _channel;
  late StreamController<MachineState> _controller;
  bool? _hasBeenWorking;
  int? _workingPin;

  @override
  Stream<MachineState> subscribe() {
    try {
      _controller = StreamController.broadcast(
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
          // final inStates =
          //     json.decode(value)['msg']['digital_out_states'] as List<dynamic>;
          final data = json.decode(value)['msg'];

          if (data == null) {
            return;
          }

          if (!data.keys.contains('digital_out_states')) {
            return;
          }

          final pinStates = data['digital_out_states'] as List<dynamic>;

          /// Business Rule: `digital output 5번 pin` 은
          ///                로봇이 움직이는 중인지 판단하는 flag
          ///
          /// ```json
          /// {
          ///   'state': true,
          ///   'pin': 5
          /// }
          /// ```
          final isWorking = pinStates.removeAt(5)['state'] as bool;

          if (isWorking == _hasBeenWorking) {
            return;
          }

          _hasBeenWorking = isWorking;

          MachineState pinState;

          if (isWorking) {
            final index =
                pinStates.indexWhere((inState) => inState['state'] as bool);

            if (index < 0) {
              _workingPin = null;
              pinState = const MachineState.empty();
            } else {
              _workingPin = index;
              pinState = MachineState.busy(index);
            }
          } else {
            /// Business Rule: `digital output 6번 pin` 이 켜져있는 경우,
            ///                로봇이 움직이는 것은 멈췄지만, 방해로 물건을 놓지 못하고
            ///                집게에 들고 있는 경우임
            ///
            /// 이전에 List 에서 5번 pin 을 pop 했기 때문에, 6번을 꺼내는 index는 5번
            final isPaused = pinStates.removeAt(5)['state'] as bool;

            if (isPaused) {
              pinState = MachineState.blocked(_workingPin!);
            } else {
              _workingPin = null;
              pinState = const MachineState.empty();
            }
          }

          _controller.add(pinState);
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

      return _controller.stream;
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  FutureOr<void> unsubscribe() async {
    _controller.close();
  }
}
