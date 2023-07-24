// ignore_for_file: public_member_api_docs, sort_constructors_first
class MachineIoState {
  const MachineIoState._([
    int? index,
  ]) : _workingIndex = index;

  const factory MachineIoState.busy(int workingIndex) = MachineIoState._;
  const factory MachineIoState.empty() = MachineIoState._;

  final int? _workingIndex;

  int get index => isBusy ? _workingIndex! : -1;

  bool get isBusy => _workingIndex != null;
}
