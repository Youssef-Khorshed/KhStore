import 'package:dartz/dartz.dart';
import 'package:store/Features/auth/Domain/Entity/userinfo.dart';
import 'package:store/Features/auth/Domain/repo/repo.dart';
import '../../../../Core/error.dart';
import '../Entity/user.dart';

class UpdateProfileUseCase {
  AuthRepo repo;
  UpdateProfileUseCase({required this.repo});
  Future<Either<Failure, UserEntiy>> call({required UserData userEntiy}) {
    return repo.updateprofile(userinfo: userEntiy);
  }
}
