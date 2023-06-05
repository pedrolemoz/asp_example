import 'package:asp/asp.dart';

import '../../dtos/login_with_credentials_dto.dart';
import '../../exceptions/auth_exceptions.dart';
import '../../services/authentication_service.dart';
import '../common/auth_common_states.dart';
import 'login_actions.dart';
import 'login_atoms.dart';
import 'login_states.dart';

class LoginReducer extends Reducer {
  final AuthenticationService _authenticationService;

  LoginReducer(this._authenticationService) {
    on(() => [loginWithCredentialsAction], _onLoginWithCredentialsAction);
    on(
      () => [toggleLoginPasswordVisibilityAction],
      _onToggleLoginPasswordVisibilityAction,
    );
  }

  Future<void> _onLoginWithCredentialsAction() async {
    loginState.setValue(AuthenticatingUserState());

    final dto = LoginWithCredentialsDTO(
      email: loginEmailText.value,
      password: loginPasswordText.value,
    );

    final result = await _authenticationService.loginWithCredentials(dto);

    result.fold(
      (success) {
        loginState.setValue(
          SuccesfullyAuthenticatedUserState(
            userModel: success,
          ),
        );
      },
      (failure) {
        switch (failure.runtimeType) {
          case InvalidEmailException:
            loginState.setValue(
              InvalidEmailState(
                description: failure.description,
              ),
            );
            break;
          case InvalidPasswordException:
            loginState.setValue(
              InvalidPasswordState(
                description: failure.description,
              ),
            );
            break;
          default:
            loginState.setValue(
              UnableToAuthenticateUserState(
                description: failure.description,
              ),
            );
        }
      },
    );
  }

  Future<void> _onToggleLoginPasswordVisibilityAction() async {
    loginPasswordTextVisibility.setValue(!loginPasswordTextVisibility.value);
  }
}
