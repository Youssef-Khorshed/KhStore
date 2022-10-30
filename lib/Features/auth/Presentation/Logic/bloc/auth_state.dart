part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class Login_Register_Success_State extends AuthState {
  UserEntiy entiy;
  bool change;
  Login_Register_Success_State({required this.entiy, required this.change});
  @override
  List<Object?> get props => [entiy];
}

class LoadingAuth extends AuthState {
  bool change;
  LoadingAuth({required this.change});
  @override
  List<Object?> get props => [change];
}

class Login_Register_Failure_State extends AuthState {
  String message;
  bool change;
  Login_Register_Failure_State({required this.message, required this.change});
  @override
  List<Object?> get props => [message];
}
