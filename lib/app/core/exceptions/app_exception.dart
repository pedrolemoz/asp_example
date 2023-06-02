class AppException implements Exception {
  final String description;
  final Object? error;
  late final StackTrace stackTrace;

  AppException({
    required this.description,
    this.error,
    StackTrace? stackTrace,
  }) : stackTrace = stackTrace ?? StackTrace.current;
}
