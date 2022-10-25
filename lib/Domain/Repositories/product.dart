import 'package:dartz/dartz.dart';
import 'package:store/Domain/Entities/products.dart';
import '../../Core/error.dart';

abstract class ProductRepo {
  Future<Either<Failure, Unit>> addproduct({required Product product});
  Future<Either<Failure, List<Product>>> getAllproducts();
  Future<Either<Failure, Unit>> updateproduct({required Product product});
  Future<Either<Failure, Unit>> deleteproduct({required int id});
}
