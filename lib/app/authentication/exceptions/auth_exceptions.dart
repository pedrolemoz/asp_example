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

class AuthException extends AppException {
  AuthException({
    required super.description,
    super.error,
    super.stackTrace,
  });
}

class InvalidEmailException extends AuthException {
  InvalidEmailException({
    super.description = 'The email is not valid',
    super.stackTrace,
  });
}

class InvalidPasswordException extends AuthException {
  InvalidPasswordException({
    super.description = 'The password is not valid',
    super.stackTrace,
  });
}
