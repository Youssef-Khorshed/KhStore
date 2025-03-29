import 'package:dartz/dartz.dart';
import 'package:store/Features/auth/Domain/repo/repo.dart';
import '../../../../Core/error.dart';

class ForgetPasswordUseCase {
  AuthRepo repo;
  ForgetPasswordUseCase({required this.repo});
  Future<Either<Failure, String>> call({
    required String newpassword,
  }) {
    return repo.fogetpassword(
      newpassword: newpassword,
    );
  }
}
