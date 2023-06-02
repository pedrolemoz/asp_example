import 'package:result_dart/result_dart.dart';

import '../../../core/exceptions/app_exception.dart';
import '../../../core/models/user_model.dart';
import '../dtos/login_with_credentials_dto.dart';
import '../dtos/register_new_user_dto.dart';

class AuthenticationService {
  AsyncResult<UserModel, AppException> loginWithCredentials(
    LoginWithCredentialsDTO dto,
  ) async {
    return dto.validate().toAsyncResult().flatMap((_) async {
      await Future.delayed(const Duration(seconds: 3));
      return Success(
        UserModel(
          name: dto.email.split('@').first,
          email: dto.email,
        ),
      );
    });
  }

  AsyncResult<UserModel, AppException> registerNewUser(
    RegisterNewUserDTO dto,
  ) async {
    return dto.validate().toAsyncResult().flatMap((_) async {
      await Future.delayed(const Duration(seconds: 3));
      return Success(
        UserModel(
          name: dto.userName,
          email: dto.email,
        ),
      );
    });
  }
}
