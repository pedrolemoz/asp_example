import 'package:result_dart/result_dart.dart';

import '../exceptions/auth_exceptions.dart';
import '../mixins/email_validation_mixin.dart';
import '../mixins/password_validation_mixin.dart';

class LoginWithCredentialsDTO
    with EmailValidationMixin, PasswordValidationMixin {
  final String email;
  final String password;

  const LoginWithCredentialsDTO({
    required this.email,
    required this.password,
  });

  Result<LoginWithCredentialsDTO, AppException> validate() {
    return validateEmail(email)
        .flatMap((_) => validatePassword(password))
        .pure(this);
  }
}
