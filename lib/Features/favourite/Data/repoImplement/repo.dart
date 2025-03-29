import 'package:store/Core/exception.dart';
import 'package:store/Core/internet.dart';
import 'package:store/Core/error.dart';
import 'package:dartz/dartz.dart';
import 'package:store/Features/auth/Data/DataSource/local.dart';
import 'package:store/Features/favourite/Data/DataSource/local.dart';
import 'package:store/Features/favourite/Data/DataSource/remote.dart';
import 'package:store/Features/favourite/domain/entity/favEntity.dart';
import 'package:store/Features/favourite/domain/repo/repo.dart';

class FavRepoImp extends FavRepo {
  NetworkInfo networkInfo;
  LocalFav localFav;
  RemoteFav remoteFav;
  LocalAuth localAuth;
  FavRepoImp(
      {required this.remoteFav,
      required this.localFav,
      required this.networkInfo,
      required this.localAuth});

  @override
  Future<Either<Failure, String>> addTofav({required int productid}) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await localAuth.getcashedtoken();
        final value =
            await remoteFav.addfav(productid: productid, token: token);
        return Right(value);
      } on ApiException {
        return Left(ApiFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, FavEntity>> getfav() async {
    if (await networkInfo.isConnected) {
      try {
        final token = await localAuth.getcashedtoken();
        final value = await remoteFav.getfav(token: token);
        localFav.cashfav(favdata: value);
        return Right(value);
      } on ApiException {
        return Left(ApiFailure());
      }
    } else {
      try {
        return Right(await localFav.getcashedfav());
      } on CashException {
        return Left(CashFailure());
      }
    }
  }
}
