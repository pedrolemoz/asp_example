import 'package:asp/asp.dart';

import '../../dtos/login_with_credentials_dto.dart';
import '../../services/authentication_service.dart';
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
    loginLoadingState.setValue(true);

    final dto = LoginWithCredentialsDTO(
      email: loginEmailText.value,
      password: loginPasswordText.value,
    );

    final result = await _authenticationService.loginWithCredentials(dto);

    result.fold(
      (success) {
        loginState.setValue(success);
        loginErrorState.setValue(null);
      },
      loginErrorState.setValue,
    );

    loginLoadingState.setValue(false);
  }

  Future<void> _onToggleLoginPasswordVisibilityAction() async {
    loginPasswordTextVisibility.setValue(!loginPasswordTextVisibility.value);
  }
}
