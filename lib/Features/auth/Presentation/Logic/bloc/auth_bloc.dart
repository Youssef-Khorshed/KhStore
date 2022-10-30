// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:store/Core/getFailure.dart';
import 'package:store/Features/auth/Domain/Entity/user.dart';
import 'package:store/Features/auth/Domain/Entity/userinfo.dart';
import 'package:store/Features/auth/Domain/UseCases/login.dart';
import 'package:store/Features/auth/Domain/UseCases/register.dart';

import '../../../../../Core/error.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  LoginUseCase loginUseCase;
  RegisterUseCase registerUseCase;
  bool change = true;
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  TextEditingController signup_email = TextEditingController();
  TextEditingController signup_username = TextEditingController();
  TextEditingController signup_password = TextEditingController();
  TextEditingController signup_phone = TextEditingController();
  UserEntiy? userentity;
  AuthBloc({required this.loginUseCase, required this.registerUseCase})
      : super(AuthInitial()) {
    on<AuthEvent>;
    on<LoginEvent>(login);
    on<RegisterEvent>(register);
  }

  FutureOr<void> login(LoginEvent event, Emitter<AuthState> emit) async {
    final value =
        await loginUseCase.call(email: event.email, password: event.password);
    get_state(value: value);
  }

  FutureOr<void> register(RegisterEvent event, Emitter<AuthState> emit) async {
    final value = await registerUseCase.call(userinfo: event.userEntiy);
    get_state(value: value);
  }

  void get_state({required Either<Failure, UserEntiy> value}) {
    cleartext();
    change = false;
    emit(LoadingAuth(change: change));

    value.fold((fail) {
      change = true;

      Timer(Duration(seconds: 1), () {
        emit(Login_Register_Failure_State(
            message: getfailure(failure: fail), change: change));
      });
    }, (entity) {
      userentity = entity;
      change = true;
      Timer(Duration(seconds: 1), () {
        emit(Login_Register_Success_State(entiy: entity, change: change));
      });
    });
  }

  void cleartext() {
    email_controller.clear();
    password_controller.clear();
    signup_email.clear();
    signup_username.clear();
    signup_password.clear();
    signup_phone.clear();
  }
}
