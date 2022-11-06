import 'package:dartz/dartz.dart';
import 'package:store/Features/favourite/domain/entity/favEntity.dart';
import '../../../../Core/error.dart';

abstract class FavRepo {
  Future<Either<Failure, String>> addTofav({required int productid});
  Future<Either<Failure, FavEntity>> getfav();
}
