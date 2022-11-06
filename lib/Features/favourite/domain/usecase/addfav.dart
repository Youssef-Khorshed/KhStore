import 'package:dartz/dartz.dart';
import 'package:store/Features/favourite/domain/repo/repo.dart';
import '../../../../Core/error.dart';

class AddTofavUsecase {
  FavRepo repo;
  AddTofavUsecase({required this.repo});
  Future<Either<Failure, String>> call({required int productid}) async {
    return await repo.addTofav(productid: productid);
  }
}
