import 'package:store/Core/exception.dart';
import 'package:store/Core/internet.dart';
import 'package:store/Features/auth/Data/DataSource/local.dart';
import 'package:store/Features/auth/Data/DataSource/remote.dart';
import 'package:store/Features/auth/Domain/Entity/userinfo.dart';
import 'package:store/Features/auth/Domain/Entity/user.dart';
import 'package:store/Core/error.dart';
import 'package:dartz/dartz.dart';
import 'package:store/Features/auth/Domain/repo/repo.dart';

class AuthRepoImp extends AuthRepo {
  NetworkInfo networkInfo;
  LocalAuth localAuth;
  AuthRemote remote;
  AuthRepoImp(
      {required this.remote,
      required this.localAuth,
      required this.networkInfo});
  @override
  Future<Either<Failure, UserEntiy>> login(
      {required String email, required String password}) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await remote.login(email: email, password: password);
        if (res.data == null) {
          return Left(AuthFailure());
        } else {
          await localAuth.cashtoken(tokenvalue: res.data!.token!);
          await localAuth.cashpassword(password: password);
          return Right(res);
        }
      } on AuthException {
        return Left(AuthFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntiy>> register(
      {required UserData userinfo}) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await remote.register(userinfo: userinfo);
        await localAuth.cashtoken(tokenvalue: res.data!.token!);
        await localAuth.cashpassword(password: userinfo.password!);
        return Right(res);
      } on AuthException {
        return Left(AuthFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, String>> logout() async {
    if (await networkInfo.isConnected) {
      try {
        final token = await localAuth.getcashedtoken();
        final res = await remote.logout(token: token);
        await localAuth.cashtoken(tokenvalue: '');
        return Right(res);
      } on AuthException {
        return Left(AuthFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntiy>> updateprofile(
      {required UserData userinfo}) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await localAuth.getcashedtoken();
        final res =
            await remote.updateProfile(userinfo: userinfo, token: token);
        return Right(res);
      } on AuthException {
        return Left(AuthFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, String>> fogetpassword(
      {required String newpassword}) async {
    if (await networkInfo.isConnected) {
      try {
        final oldpassword = await localAuth.getcashedpassword();
        final token = await localAuth.getcashedtoken();
        await localAuth.cashpassword(password: newpassword);
        final res = await remote.forgetpassword(
            oldpassword: oldpassword,
            newpassword: newpassword,
            usertoken: token);
        return Right(res);
      } on AuthException {
        return Left(AuthFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }
}
