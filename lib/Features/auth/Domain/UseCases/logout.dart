import 'package:dartz/dartz.dart';
import 'package:store/Features/auth/Domain/repo/repo.dart';
import '../../../../Core/error.dart';

class LogoutUseCase {
  AuthRepo repo;
  LogoutUseCase({required this.repo});
  Future<Either<Failure, String>> call() {
    return repo.logout();
  }
}
