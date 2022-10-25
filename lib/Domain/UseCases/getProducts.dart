// ignore: file_names
import 'package:dartz/dartz.dart';
import 'package:store/Domain/Entities/products.dart';
import '../../Core/error.dart';
import '../Repositories/product.dart';

class GetproductUsecase {
  ProductRepo repo;
  GetproductUsecase({required this.repo});
  Future<Either<Failure, List<Product>>> call() async {
    return await repo.getAllproducts();
  }
}
