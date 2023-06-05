abstract class IAppState {}

abstract class ISuccessState extends IAppState {}

abstract class IErrorState extends IAppState {}

abstract class IProcessingState extends IAppState {}

class InitialState implements IAppState {}
