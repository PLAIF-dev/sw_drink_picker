import 'package:drink_picker/pick/actor/application/bloc/pick_state_notifier.dart';

abstract class PickEvent {
  const factory PickEvent.pick(int index) = PickPickEvent._;
  void handle(PickStateNotifier context);
}

class PickPickEvent implements PickEvent {
  const PickPickEvent._(this.index);

  final int index;
  @override
  void handle(PickStateNotifier context) {
    context.pick(index);
  }
}
