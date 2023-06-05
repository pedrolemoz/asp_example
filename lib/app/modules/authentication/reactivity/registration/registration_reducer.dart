import 'package:asp/asp.dart';

import '../../dtos/register_new_user_dto.dart';
import '../../exceptions/auth_exceptions.dart';
import '../../services/authentication_service.dart';
import '../common/auth_common_states.dart';
import '../login/login_states.dart';
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
    registrationState.setValue(RegisteringUserState());

    final dto = RegisterNewUserDTO(
      userName: registrationUserNameText.value,
      email: registrationEmailText.value,
      password: registrationPasswordText.value,
    );

    final result = await _authenticationService.registerNewUser(dto);

    result.fold(
      (success) {
        registrationState.setValue(
          SuccesfullyRegisteredUserState(
            userModel: success,
          ),
        );
      },
      (failure) {
        switch (failure.runtimeType) {
          case InvalidUserNameException:
            registrationState.setValue(
              InvalidUserNameState(
                description: failure.description,
              ),
            );
            break;
          case InvalidEmailException:
            registrationState.setValue(
              InvalidEmailState(
                description: failure.description,
              ),
            );
            break;
          case InvalidPasswordException:
            registrationState.setValue(
              InvalidPasswordState(
                description: failure.description,
              ),
            );
            break;
          default:
            registrationState.setValue(
              UnableToAuthenticateUserState(
                description: failure.description,
              ),
            );
        }
      },
    );
  }

  Future<void> _onToggleRegistrationPasswordVisibilityAction() async {
    registrationPasswordTextVisibility
        .setValue(!registrationPasswordTextVisibility.value);
  }
}
