import 'package:asp/asp.dart';

import '../../../../core/models/user_model.dart';
import '../../../../core/presentation/base_states.dart';

final loginState = Atom<IAppState>(InitialState());

class AuthenticatingUserState implements IProcessingState {}

class UnableToAuthenticateUserState implements IErrorState {
  final String description;

  UnableToAuthenticateUserState({required this.description});
}

class SuccesfullyAuthenticatedUserState implements ISuccessState {
  final UserModel userModel;

  SuccesfullyAuthenticatedUserState({required this.userModel});
}
