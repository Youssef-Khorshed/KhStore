import 'package:dartz/dartz.dart';
import 'package:store/Features/product/Domain/Entities/banner/banner.dart';
import '../../../../Core/error.dart';
import '../Repositories/product.dart';

class GetBannerUseCase {
  ProductRepo repo;
  GetBannerUseCase({required this.repo});
  Future<Either<Failure, List<BannerData>>> call() async {
    return await repo.getbanner();
  }
}
