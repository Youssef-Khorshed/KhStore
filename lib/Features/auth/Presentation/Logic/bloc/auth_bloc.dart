// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:store/Core/getFailure.dart';
import 'package:store/Features/auth/Domain/Entity/user.dart';
import 'package:store/Features/auth/Domain/Entity/userinfo.dart';
import 'package:store/Features/auth/Domain/UseCases/forgetpassword.dart';
import 'package:store/Features/auth/Domain/UseCases/login.dart';
import 'package:store/Features/auth/Domain/UseCases/logout.dart';
import 'package:store/Features/auth/Domain/UseCases/register.dart';
import 'package:store/Features/auth/Domain/UseCases/updateprofile.dart';

import '../../../../../Core/error.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  LoginUseCase loginUseCase;
  RegisterUseCase registerUseCase;
  LogoutUseCase logoutUseCase;
  ForgetPasswordUseCase forgetPasswordUseCase;
  UpdateProfileUseCase updateProfileUseCase;
  bool change = true;
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  TextEditingController signup_email = TextEditingController();
  TextEditingController signup_username = TextEditingController();
  TextEditingController signup_password = TextEditingController();
  TextEditingController signup_phone = TextEditingController();
  UserEntiy? userentity;
  AuthBloc(
      {required this.loginUseCase,
      required this.registerUseCase,
      required this.updateProfileUseCase,
      required this.logoutUseCase,
      required this.forgetPasswordUseCase})
      : super(AuthInitial()) {
    on<AuthEvent>;
    on<LoginEvent>(login);
    on<RegisterEvent>(register);
    on<UpdateEvent>(update);
    on<LogoutEvent>(logout);
    on<ForgetPasswordEvent>(forgetpassword);
  }

  FutureOr<void> login(LoginEvent event, Emitter<AuthState> emit) async {
    emit(LoadingAuth(change: change));
    final value =
        await loginUseCase.call(email: event.email, password: event.password);
    cleartext();
    change = false;

    value.fold((fail) {
      change = true;
      emit(AuthFailState(message: getfailure(failure: fail), change: change));
    }, (entity) {
      userentity = entity;
      change = true;
      emit(Login_Success_State(entiy: entity, change: change));
    });
  }

  FutureOr<void> register(RegisterEvent event, Emitter<AuthState> emit) async {
    final value = await registerUseCase.call(userinfo: event.userEntiy);
    cleartext();
    change = false;
    emit(LoadingAuth(change: change));

    value.fold((fail) {
      change = true;
      emit(AuthFailState(message: getfailure(failure: fail), change: change));
    }, (entity) {
      userentity = entity;
      change = true;
      emit(Registe_Success_State(entiy: entity, change: change));
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

  FutureOr<void> update(UpdateEvent event, Emitter<AuthState> emit) async {
    final value = await updateProfileUseCase.call(userEntiy: event.userEntiy);
    change = false;
    emit(LoadingAuth(change: change));
    value.fold((fail) {
      change = true;
      emit(AuthFailState(message: getfailure(failure: fail), change: change));
    }, (entity) {
      userentity = entity;
      change = true;
      emit(Update_Success_State(entiy: entity, change: change));
    });
  }

  FutureOr<void> logout(LogoutEvent event, Emitter<AuthState> emit) async {
    final value = await logoutUseCase.call();
    change = false;
    emit(LoadingAuth(change: change));
    value.fold((fail) {
      change = true;
      emit(AuthFailState(message: getfailure(failure: fail), change: change));
    }, (message) {
      change = true;
      emit(LogoutSuccess(message: message));
    });
  }

  FutureOr<void> forgetpassword(
      ForgetPasswordEvent event, Emitter<AuthState> emit) async {
    final value = await forgetPasswordUseCase.call(newpassword: event.password);
    emit(LoadingAuth(change: change));
    value.fold((fail) {
      change = true;
      emit(AuthFailState(message: getfailure(failure: fail), change: change));
    }, (message) {
      change = true;
      emit(ForgetPasswordSuccess(message: message));
    });
  }
}
