abstract class AuthEvent {
  AuthEvent();
}

class Login extends AuthEvent{
  Login();
}

class SetPassword extends AuthEvent{
  final String password;
  SetPassword({required this.password});
}

class SetEmail extends AuthEvent{
  final String email;
  SetEmail({required this.email});
}

class CleanLoginStatus extends AuthEvent{
  CleanLoginStatus();
}

class PasswordRecovery extends AuthEvent{
  PasswordRecovery();
}