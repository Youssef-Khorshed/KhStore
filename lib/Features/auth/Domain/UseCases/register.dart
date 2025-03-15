import 'package:dartz/dartz.dart';
import 'package:store/Features/auth/Domain/Entity/userinfo.dart';
import '../../../../Core/error.dart';
import '../Entity/user.dart';
import '../repo/repo.dart';

class RegisterUseCase {
  AuthRepo repo;
  RegisterUseCase({required this.repo});
  Future<Either<Failure, UserEntiy>> call({required UserData userinfo}) {
    return repo.register(userinfo: userinfo);
  }
}
