import 'package:dartz/dartz.dart';
import 'package:store/Features/auth/Domain/Entity/user.dart';
import 'package:store/Features/product/Domain/Entities/categories/Categoty.dart';
import 'package:store/Features/product/Domain/Entities/banner/banner.dart';
import 'package:store/Features/product/Domain/Entities/product/insidedata.dart';
import 'package:store/Features/product/Domain/Entities/product/outsidedata.dart';
import '../../../../Core/error.dart';

abstract class ProductRepo {
  // Future<Either<Failure, Unit>> addproduct({required Product product});
  Future<Either<Failure, List<InsideData>>> getAllproducts();
  Future<Either<Failure, List<BannerData>>> getbanner();
  Future<Either<Failure, List<Category>>> getcategories();
  Future<Either<Failure, List<InsideData>>> getcategory({required int id});
  Future<Either<Failure, UserEntiy>> getuserdata();
}
