part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class LoginEvent extends AuthEvent {
  String email, password;
  LoginEvent({required this.email, required this.password});
  List<Object?> get props => [email, password];
}

class ForgetPasswordEvent extends AuthEvent {
  String password;
  ForgetPasswordEvent({required this.password});
  List<Object?> get props => [password];
}

class RegisterEvent extends AuthEvent {
  UserData userEntiy;
  RegisterEvent({required this.userEntiy});
  List<Object?> get props => [userEntiy];
}

class UpdateEvent extends AuthEvent {
  UserData userEntiy;
  UpdateEvent({required this.userEntiy});
  List<Object?> get props => [userEntiy];
}

class LogoutEvent extends AuthEvent {
  List<Object?> get props => [];
}
