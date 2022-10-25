import 'package:dartz/dartz.dart';
import '../../Core/error.dart';
import '../Entities/products.dart';
import '../Repositories/product.dart';

class UpdateproductUsecase {
  ProductRepo repo;
  UpdateproductUsecase({required this.repo});
  Future<Either<Failure, Unit>> call({required Product product}) async {
    return await repo.updateproduct(product: product);
  }
}
