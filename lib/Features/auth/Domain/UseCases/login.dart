import 'package:dartz/dartz.dart';
import 'package:store/Features/auth/Domain/repo/repo.dart';

import '../../../../Core/error.dart';
import '../Entity/user.dart';

class LoginUseCase {
  AuthRepo repo;
  LoginUseCase({required this.repo});
  Future<Either<Failure, UserEntiy>> call(
      {required String email, required String password}) {
    return repo.login(email: email, password: password);
  }
}
