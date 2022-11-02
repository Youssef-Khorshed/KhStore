import 'package:dartz/dartz.dart';
import 'package:store/Features/cart/domain/entity/Carts.dart';

import '../../../../Core/error.dart';
import '../../../auth/Domain/Entity/user.dart';

abstract class CartRepo {
  Future<Either<Failure, Unit>> addToCart(
      {required int productid, required int quantity});
  Future<Either<Failure, Unit>> removeFromCart({required int cartItemId});
  Future<Either<Failure, Unit>> updateCart({required int cartItemId});
  Future<Either<Failure, Carts>> register();
}
