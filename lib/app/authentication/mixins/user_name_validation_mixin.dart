import 'package:result_dart/result_dart.dart';

import '../exceptions/auth_exceptions.dart';

mixin class UserNameValidationMixin {
  Result<Unit, AppException> validateUserName(String userName) {
    if (userName.isEmpty) {
      return Failure(
        InvalidUserNameException(description: 'The user name cannot be empty'),
      );
    }
    return const Success(unit);
  }
}
