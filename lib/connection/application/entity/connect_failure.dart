enum ConnectFailure {
  invalid('Invalid Connection'),
  ;

  const ConnectFailure(this.message);

  final String message;
}
