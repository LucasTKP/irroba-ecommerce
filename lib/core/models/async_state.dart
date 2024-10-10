enum AsyncState {
  initial,
  loading,
  success,
  error,
  ;

  bool get isInitial => this == AsyncState.initial;
  bool get isLoading => this == AsyncState.loading;
  bool get isSuccess => this == AsyncState.success;
  bool get isError => this == AsyncState.error;
}
