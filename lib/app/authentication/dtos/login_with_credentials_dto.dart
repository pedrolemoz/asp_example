import 'package:result_dart/result_dart.dart';

import '../../core/regular_expressions/regular_expressions.dart';
import '../exceptions/auth_exceptions.dart';

class LoginWithCredentialsDTO {
  final String email;
  final String password;

  const LoginWithCredentialsDTO({
    required this.email,
    required this.password,
  });

  Result<LoginWithCredentialsDTO, AppException> validate() {
    return _validateEmail().flatMap((_) => _validatePassword()).pure(this);
  }

  Result<Unit, AppException> _validateEmail() {
    if (email.isEmpty) {
      return Failure(
        InvalidEmailException(description: 'The email cannot be empty'),
      );
    }
    final hasValidEmail = RegularExpressions.email.hasMatch(email);
    if (hasValidEmail) return const Success(unit);
    return Failure(InvalidEmailException());
  }

  Result<Unit, AppException> _validatePassword() {
    final hasAtLeastSixCharacters = password.length >= 6;
    final hasUpperCaseCharacters =
        RegularExpressions.upperCaseCharacters.hasMatch(password);
    final hasLowerCaseCharacters =
        RegularExpressions.lowerCaseCharacters.hasMatch(password);
    final hasNumbers = RegularExpressions.numbers.hasMatch(password);
    final hasSpecialCharacters =
        RegularExpressions.specialCharacters.hasMatch(password);

    if (!hasAtLeastSixCharacters) {
      return Failure(
        InvalidPasswordException(
          description: 'The password must contains at least 6 characters',
        ),
      );
    }

    if (!hasUpperCaseCharacters) {
      return Failure(
        InvalidPasswordException(
          description: 'The password must contains at one uppercase character',
        ),
      );
    }

    if (!hasLowerCaseCharacters) {
      return Failure(
        InvalidPasswordException(
          description: 'The password must contains at one lowercase character',
        ),
      );
    }

    if (!hasNumbers) {
      return Failure(
        InvalidPasswordException(
          description: 'The password must contains at least one number',
        ),
      );
    }

    if (!hasSpecialCharacters) {
      return Failure(
        InvalidPasswordException(
          description:
              'The password must contains at least one special character',
        ),
      );
    }

    return const Success(unit);
  }
}
