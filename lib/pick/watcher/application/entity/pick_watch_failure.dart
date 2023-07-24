enum PickWatchFailure {
  refused('Refused by robot'),
  ;

  const PickWatchFailure(this.message);

  final String message;
}
