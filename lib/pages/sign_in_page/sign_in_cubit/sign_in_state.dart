abstract class LoginScreenStates {}

class LoginScreenInitState extends LoginScreenStates {}

class LoginScreenStateSuccess extends LoginScreenStates {}

class LoginScreenStateFailed extends LoginScreenStates {
  final String? error;
  LoginScreenStateFailed({this.error});
}

class LoginScreenStateLoading extends LoginScreenStates {}

class LoginScreenStateShowPassword extends LoginScreenStates {}
