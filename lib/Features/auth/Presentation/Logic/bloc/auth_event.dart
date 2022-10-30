part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class LoginEvent extends AuthEvent {
  String email, password;
  LoginEvent({required this.email, required this.password});
  List<Object?> get props => [email, password];
}

class RegisterEvent extends AuthEvent {
  UserData userEntiy;
  RegisterEvent({required this.userEntiy});
  List<Object?> get props => [userEntiy];
}
