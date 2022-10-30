import 'package:dartz/dartz.dart';
import 'package:store/Features/product/Domain/Entities/product/insidedata.dart';
import 'package:store/Features/product/Domain/Repositories/product.dart';
import '../../../../Core/error.dart';

class GetCategoryUseCase {
  ProductRepo repo;
  GetCategoryUseCase({required this.repo});
  Future<Either<Failure, List<InsideData>>> call({required int id}) async {
    return await repo.getcategory(id: id);
  }
}
