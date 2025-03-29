import 'package:dartz/dartz.dart';
import 'package:store/Features/product/Domain/Repositories/product.dart';

import '../../../../Core/error.dart';
import '../../../auth/Domain/Entity/user.dart';

class UserDataUsecase {
  ProductRepo repo;
  UserDataUsecase({required this.repo});
  Future<Either<Failure, UserEntiy>> call() {
    return repo.getuserdata();
  }
}
