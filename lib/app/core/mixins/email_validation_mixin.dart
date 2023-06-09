import 'package:result_dart/result_dart.dart';

import '../../modules/authentication/exceptions/auth_exceptions.dart';
import '../exceptions/app_exception.dart';
import '../regular_expressions/regular_expressions.dart';

mixin class EmailValidationMixin {
  Result<Unit, AppException> validateEmail(String email) {
    if (email.isEmpty) {
      return Failure(
        InvalidEmailException(description: 'The email cannot be empty'),
      );
    }
    final hasValidEmail = RegularExpressions.email.hasMatch(email);
    if (hasValidEmail) return const Success(unit);
    return Failure(InvalidEmailException());
  }
}
