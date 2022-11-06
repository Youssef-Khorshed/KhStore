part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class Registe_Success_State extends AuthState {
  UserEntiy entiy;
  bool change;
  Registe_Success_State({required this.entiy, required this.change});
  @override
  List<Object?> get props => [entiy];
}

class Login_Success_State extends AuthState {
  UserEntiy entiy;
  bool change;
  Login_Success_State({required this.entiy, required this.change});
  @override
  List<Object?> get props => [entiy];
}

class Update_Success_State extends AuthState {
  UserEntiy entiy;
  bool change;
  Update_Success_State({required this.entiy, required this.change});
  @override
  List<Object?> get props => [entiy];
}

class LoadingAuth extends AuthState {
  bool change;
  LoadingAuth({required this.change});
  @override
  List<Object?> get props => [change];
}

class AuthFailState extends AuthState {
  String message;
  bool change;
  AuthFailState({required this.message, required this.change});
  @override
  List<Object?> get props => [message];
}

class LogoutSuccess extends AuthState {
  String message;
  LogoutSuccess({
    required this.message,
  });
  @override
  List<Object?> get props => [message];
}

class ForgetPasswordSuccess extends AuthState {
  String message;
  ForgetPasswordSuccess({
    required this.message,
  });
  @override
  List<Object?> get props => [message];
}
