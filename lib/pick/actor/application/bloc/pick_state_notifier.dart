import 'package:drink_picker/pick/actor/application/bloc/pick_event.dart';
import 'package:drink_picker/pick/actor/application/bloc/pick_state.dart';
import 'package:drink_picker/pick/actor/application/service/pick_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PickStateNotifier extends StateNotifier<PickState> {
  PickStateNotifier(this._service) : super(const PickState.idle());

  final PickService _service;

  void mapEventToState(PickEvent event) {
    event.handle(this);
  }

  Future<void> pick(int index) async {
    state = const PickState.picking();
    final failOrSuccess = await _service.pick(index);
    state = failOrSuccess.fold(
      (l) => PickState.failed(l),
      (r) => const PickState.idle(),
    );
  }
}
