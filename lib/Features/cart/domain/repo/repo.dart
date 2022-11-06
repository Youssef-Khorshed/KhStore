import 'package:dartz/dartz.dart';
import 'package:store/Features/cart/domain/entity/Carts.dart';
import 'package:store/Features/cart/domain/entity/cartEntity.dart';
import '../../../../Core/error.dart';

abstract class CartRepo {
  Future<Either<Failure, String>> addToCart(
      {required int productid, required int quantity});
  Future<Either<Failure, String>> removeFromCart({required int cartItemId});
  Future<Either<Failure, String>> updateCart(
      {required int cartItemId, required int quantity});
  Future<Either<Failure, Carts>> getcart();
}
