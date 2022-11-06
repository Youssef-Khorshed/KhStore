import 'package:dartz/dartz.dart';
import 'package:store/Features/favourite/domain/entity/favEntity.dart';
import '../../../../Core/error.dart';
import '../repo/repo.dart';

class GetFavUseCase {
  FavRepo repo;
  GetFavUseCase({required this.repo});
  Future<Either<Failure, FavEntity>> call() async {
    return await repo.getfav();
  }
}
