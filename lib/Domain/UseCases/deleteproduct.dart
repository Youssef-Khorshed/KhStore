import 'package:dartz/dartz.dart';
import '../../Core/error.dart';
import '../Repositories/product.dart';

class DeleteproductUsecase {
  ProductRepo repo;
  DeleteproductUsecase({required this.repo});
  Future<Either<Failure, Unit>> call({required int product}) async {
    return await repo.deleteproduct(id: product);
  }
}
