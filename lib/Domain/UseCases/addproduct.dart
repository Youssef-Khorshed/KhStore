import 'package:dartz/dartz.dart';
import 'package:store/Domain/Entities/products.dart';
import 'package:store/Domain/Repositories/product.dart';

import '../../Core/error.dart';

class AddproductUsecase {
  ProductRepo repo;
  AddproductUsecase({required this.repo});
  Future<Either<Failure, Unit>> call({required Product product}) async {
    return await repo.addproduct(product: product);
  }
}
