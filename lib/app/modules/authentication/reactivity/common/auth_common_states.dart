import '../../../../core/presentation/base_states.dart';

class InvalidUserNameState implements IErrorState {
  final String description;

  InvalidUserNameState({required this.description});
}

class InvalidEmailState implements IErrorState {
  final String description;

  InvalidEmailState({required this.description});
}

class InvalidPasswordState implements IErrorState {
  final String description;

  InvalidPasswordState({required this.description});
}
