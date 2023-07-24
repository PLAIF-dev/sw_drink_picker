import 'dart:async';

import 'package:drink_picker/pick/watcher/application/bloc/pick_watch_event.dart';
import 'package:drink_picker/pick/watcher/application/bloc/pick_watch_state.dart';
import 'package:drink_picker/pick/watcher/application/service/pick_watch_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PickWatchStateNotifier extends StateNotifier<PickWatchState> {
  PickWatchStateNotifier(this._service) : super(const PickWatchState.ready());

  final PickWatchService _service;

  void mapEventToState(PickWatchEvent event) {
    event.handle(this);
  }

  void listenRemoteChanges() {
    late final StreamController controller;
    controller = StreamController(
      onCancel: () => controller.close(),
    );

    final resultStream = _service.watchState();

    late StreamSubscription subscription;

    subscription = resultStream.listen((failOrSuccess) {
      state = failOrSuccess.fold(
        (l) => PickWatchState.failed(l),
        (r) {
          if (r.isBusy) {
            return PickWatchState.busy(r.index);
          } else {
            return const PickWatchState.ready();
          }
        },
      );
    }, onDone: () {
      controller.close();
      subscription.cancel();
    }, onError: (_) {
      controller.close();
      subscription.cancel();
    });
  }
}
