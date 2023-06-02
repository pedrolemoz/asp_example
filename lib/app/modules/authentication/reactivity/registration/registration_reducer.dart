import 'package:asp/asp.dart';

import '../../dtos/register_new_user_dto.dart';
import '../../services/authentication_service.dart';
import 'registration_actions.dart';
import 'registration_atoms.dart';
import 'registration_states.dart';

class RegistrationReducer extends Reducer {
  final AuthenticationService _authenticationService;

  RegistrationReducer(this._authenticationService) {
    on(
      () => [registerNewUserAction],
      _onRegisterNewUserAction,
    );
    on(
      () => [toggleRegistrationPasswordVisibilityAction],
      _onToggleRegistrationPasswordVisibilityAction,
    );
  }

  Future<void> _onRegisterNewUserAction() async {
    registrationLoadingState.setValue(true);

    final dto = RegisterNewUserDTO(
      userName: registrationUserNameText.value,
      email: registrationEmailText.value,
      password: registrationPasswordText.value,
    );

    final result = await _authenticationService.registerNewUser(dto);

    result.fold(
      (success) {
        registrationState.setValue(success);
        registrationErrorState.setValue(null);
      },
      registrationErrorState.setValue,
    );

    registrationLoadingState.setValue(false);
  }

  Future<void> _onToggleRegistrationPasswordVisibilityAction() async {
    registrationPasswordTextVisibility
        .setValue(!registrationPasswordTextVisibility.value);
  }
}
