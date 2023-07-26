// ignore_for_file: public_member_api_docs, sort_constructors_first
class MachineState {
  const MachineState._([
    int? index,
    this.isBlocked = false,
  ]) : _workingIndex = index;

  const factory MachineState.busy(int workingIndex) = MachineState._;
  const factory MachineState.empty() = MachineState._;
  factory MachineState.blocked(int workingIndex) =>
      MachineState._(workingIndex, true);

  final int? _workingIndex;
  final bool isBlocked;

  int get index => isBusy ? _workingIndex! : -1;

  bool get isBusy => _workingIndex != null;
}
