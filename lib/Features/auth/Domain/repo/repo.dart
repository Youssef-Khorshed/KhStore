import 'package:dartz/dartz.dart';
import 'package:store/Core/error.dart';
import 'package:store/Features/auth/Domain/Entity/user.dart';
import 'package:store/Features/auth/Domain/Entity/userinfo.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntiy>> login(
      {required String email, required String password});
  Future<Either<Failure, UserEntiy>> register({required UserData userinfo});

}
