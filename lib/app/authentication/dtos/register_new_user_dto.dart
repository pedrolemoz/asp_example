import 'package:result_dart/result_dart.dart';

import '../exceptions/auth_exceptions.dart';
import '../mixins/email_validation_mixin.dart';
import '../mixins/password_validation_mixin.dart';
import '../mixins/user_name_validation_mixin.dart';

class RegisterNewUserDTO
    with
        UserNameValidationMixin,
        EmailValidationMixin,
        PasswordValidationMixin {
  final String userName;
  final String email;
  final String password;

  const RegisterNewUserDTO({
    required this.userName,
    required this.email,
    required this.password,
  });

  Result<RegisterNewUserDTO, AppException> validate() {
    return validateUserName(userName)
        .flatMap((_) => validateEmail(email))
        .flatMap((_) => validatePassword(password))
        .pure(this);
  }
}
