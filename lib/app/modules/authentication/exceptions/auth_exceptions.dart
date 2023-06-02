import '../../../core/exceptions/app_exception.dart';

class AuthException extends AppException {
  AuthException({
    required super.description,
    super.error,
    super.stackTrace,
  });
}

class InvalidUserNameException extends AuthException {
  InvalidUserNameException({
    super.description = 'The user name is not valid',
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
