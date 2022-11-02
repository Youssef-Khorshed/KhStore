import 'package:dartz/dartz.dart';
import 'package:store/Features/cart/domain/entity/cartEntity.dart';
import 'package:store/Features/cart/domain/repo/repo.dart';
import '../../../../Core/error.dart';
import '../entity/Carts.dart';

class GetCartUseCase {
  CartRepo repo;
  GetCartUseCase({required this.repo});
  Future<Either<Failure, List<CartItems>>> call() async {
    return await repo.getcart();
  }
}
