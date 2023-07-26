import 'dart:async';

import 'package:drink_picker/pick/watcher/application/bloc/pick_watch_event.dart';
import 'package:drink_picker/pick/watcher/application/bloc/pick_watch_state.dart';
import 'package:drink_picker/pick/watcher/application/service/pick_watch_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PickWatchStateNotifier extends StateNotifier<PickWatchState> {
  PickWatchStateNotifier(this._service) : super(const PickWatchState.none());

  final PickWatchService _service;
  late StreamController _controller;

  void mapEventToState(PickWatchEvent event) {
    event.handle(this);
  }

  void subscribe() {
    _controller = StreamController.broadcast(
      onCancel: () => _controller.close(),
    );

    final resultStream = _service.subscribeState();

    late StreamSubscription subscription;

    subscription = resultStream.listen(
      (failOrSuccess) {
        state = failOrSuccess.fold(
          (l) => PickWatchState.failed(l),
          (r) {
            if (r.isBlocked) {
              return PickWatchState.blocked(r.index);
            }
            if (r.isBusy) {
              return PickWatchState.busy(r.index);
            }
            return const PickWatchState.ready();
          },
        );
      },
      onDone: () {
        _controller.close();
        subscription.cancel();
      },
      onError: (_) {
        _controller.close();
        subscription.cancel();
      },
    );
  }

  void unsubscribe() async {
    _controller.close();

    final failOrSuccess = await _service.unsubscribe();
    if (mounted) {
      state = failOrSuccess.fold(
        (l) => PickWatchState.failed(l),
        (_) => const PickWatchState.none(),
      );
    }
  }
}
