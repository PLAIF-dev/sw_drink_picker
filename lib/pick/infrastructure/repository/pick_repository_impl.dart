import 'dart:convert';

import 'package:drink_picker/connection/infrastructure/datastore/communication_channel.dart';
import 'package:drink_picker/pick/domain/repository/pick_repository.dart';
import 'package:drink_picker/pick/domain/value_object/exception.dart';
import 'package:drink_picker/core/infrastructure/entity/request.dart';

class PickRepositoryImpl implements PickRepository {
  const PickRepositoryImpl(this._channel);

  final CommunicationChannel _channel;

  @override
  Future<void> pickAt(int index) async {
    final request = Request(
      op: 'call_service',
      // test
      id: 'call_service:/ur_hardware_interface/io_states:0',
      service: '/ur_hardware_interface/set_io',
      type: '/ur_msgs/IOStates',
      args: {
        'fun': 1,
        'pin': index,
        'state': 1.0,
      },
    );

    final result = await _channel.fetch(request.encode());

    final isDone =
        (json.decode(result)["values"] as Map<String, dynamic>)['success'];

    if (!isDone) {
      throw const FailedCallException();
    }
  }
}
