import 'package:drink_picker/connection/application/bloc/connect_event.dart';
import 'package:drink_picker/connection/application/bloc/connect_state.dart';
import 'package:drink_picker/connection/application/service/connect_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConnectStateNotifier extends StateNotifier<ConnectState> {
  ConnectStateNotifier(this._service) : super(const ConnectState.none());

  final ConnectService _service;

  void mapEventToState(ConnectEvent event) {
    event.handle(this);
  }

  void connect(Uri uri) async {
    final failureOrSuccess = await _service.connect(uri);
    failureOrSuccess.fold(
      (l) => state = ConnectState.failed(l),
      (r) => state = const ConnectState.wired(),
    );
  }

  void disconnect() {
    _service.disconnect();
    state = const ConnectState.none();
  }
}
