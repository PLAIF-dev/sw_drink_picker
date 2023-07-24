import 'package:drink_picker/connection/application/bloc/connect_state.dart';
import 'package:drink_picker/connection/application/bloc/connect_state_notifier.dart';
import 'package:drink_picker/connection/application/service/connect_service.dart';
import 'package:drink_picker/connection/domain/repository/connection_repository.dart';
import 'package:drink_picker/connection/infrastructure/datastore/communication_channel.dart';
import 'package:drink_picker/connection/infrastructure/datastore/websocket_communication_channel.dart';
import 'package:drink_picker/connection/infrastructure/repository/connection_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final connectStateNotifierProvider =
    StateNotifierProvider<ConnectStateNotifier, ConnectState>(
  (ref) => ConnectStateNotifier(ref.watch(connectServiceProvider)),
);

final connectServiceProvider = Provider<ConnectService>(
  (ref) => ConnectServiceImpl(ref.watch(connectRepositoryProvider)),
);

final connectRepositoryProvider = Provider<ConnectionRepository>(
  (ref) => ConnectionRepositoryImpl(ref.watch(communicationChannelProvider)),
);

final communicationChannelProvider = Provider<CommunicationChannel>(
  (ref) => WebsocketCommunicationChannel(),
);
