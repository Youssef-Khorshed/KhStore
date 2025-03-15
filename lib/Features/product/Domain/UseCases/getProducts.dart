// ignore: file_names
import 'package:dartz/dartz.dart';
import 'package:store/Features/product/Domain/Entities/product/insidedata.dart';
import '../../../../Core/error.dart';
import '../Repositories/product.dart';

class GetproductUsecase {
  ProductRepo repo;
  GetproductUsecase({required this.repo});
  Future<Either<Failure, List<InsideData>>> call() async {
    return await repo.getAllproducts();
  }
}
