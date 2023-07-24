enum PickFailure {
  refused('Refused by robot'),
  ;

  const PickFailure(this.message);

  final String message;
}
