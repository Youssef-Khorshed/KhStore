import 'package:dartz/dartz.dart';
import 'package:store/Features/product/Domain/Entities/categories/Categoty.dart';
import 'package:store/Features/product/Domain/Repositories/product.dart';
import '../../../../Core/error.dart';

class GetCategoriesUseCase {
  ProductRepo repo;
  GetCategoriesUseCase({required this.repo});
  Future<Either<Failure, List<Category>>> call() async {
    return await repo.getcategories();
  }
}
