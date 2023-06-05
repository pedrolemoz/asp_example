import 'package:asp/asp.dart';

import '../../../../core/models/user_model.dart';
import '../../../../core/presentation/base_states.dart';

final registrationState = Atom<IAppState>(InitialState());

class RegisteringUserState implements IProcessingState {}

class UnableToRegisterUserState implements IErrorState {
  final String description;

  UnableToRegisterUserState({required this.description});
}

class SuccesfullyRegisteredUserState implements ISuccessState {
  final UserModel userModel;

  SuccesfullyRegisteredUserState({required this.userModel});
}
