import 'package:dartz/dartz.dart';
import 'package:store/Features/cart/domain/repo/repo.dart';
import '../../../../Core/error.dart';

class RemoveFromCartUsecase {
  CartRepo repo;
  RemoveFromCartUsecase({required this.repo});
  Future<Either<Failure, String>> call({required int cartItemId}) async {
    return await repo.removeFromCart(cartItemId: cartItemId);
  }
}
