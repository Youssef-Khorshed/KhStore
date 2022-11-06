import 'package:dartz/dartz.dart';
import 'package:store/Features/cart/domain/repo/repo.dart';
import '../../../../Core/error.dart';

class AddToCartUsecase {
  CartRepo repo;
  AddToCartUsecase({required this.repo});
  Future<Either<Failure, String>> call(
      {required int productid, required int quantity}) async {
    return await repo.addToCart(productid: productid, quantity: quantity);
  }
}
