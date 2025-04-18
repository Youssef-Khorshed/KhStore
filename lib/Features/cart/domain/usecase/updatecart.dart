import 'package:dartz/dartz.dart';
import 'package:store/Features/cart/domain/repo/repo.dart';
import '../../../../Core/error.dart';

class UpdateCartUsecase {
  CartRepo repo;
  UpdateCartUsecase({required this.repo});
  Future<Either<Failure, String>> call(
      {required int cartItemId, required int quantity}) async {
    return await repo.updateCart(cartItemId: cartItemId, quantity: quantity);
  }
}
