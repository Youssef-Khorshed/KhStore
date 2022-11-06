import 'package:store/Core/exception.dart';
import 'package:store/Core/internet.dart';
import 'package:store/Features/auth/Data/DataSource/local.dart';
import 'package:store/Features/auth/Domain/Entity/user.dart';
import 'package:store/Features/product/Data/datasources/local.dart';
import 'package:store/Features/product/Data/datasources/remote.dart';
import 'package:store/Core/error.dart';
import 'package:dartz/dartz.dart';
import 'package:store/Features/product/Domain/Entities/banner/banner.dart';
import 'package:store/Features/product/Domain/Entities/categories/Categoty.dart';
import 'package:store/Features/product/Domain/Entities/product/insidedata.dart';
import 'package:store/Features/product/Domain/Repositories/product.dart';

import '../../../../Core/strings.dart';

typedef Future<Unit> add_delete_update_post();

class ProductRepoImp extends ProductRepo {
  RemoteDataSource remote;
  LocalDataSource local;
  LocalAuth localAuth;
  NetworkInfo connection;
  ProductRepoImp(
      {required this.local,
      required this.remote,
      required this.connection,
      required this.localAuth});

  @override
  Future<Either<Failure, List<InsideData>>> getAllproducts() async {
    if (await connection.isConnected) {
      // return api data
      try {
        final products = await remote.getAllproducts();
        await local.cashproducts(products: products);
        return Right(products);
      } on ApiException {
        return Left(ApiFailure());
      }
    } else {
      // return cashed data
      try {
        return Right(await local.getProducts());
      } on CashException {
        print('cash errpr');
        return Left(CashFailure());
      }
    }
  }

// ignore: non_constant_identifier_names
  // Future<Either<Failure, Unit>> method(
  //     {
  //     // ignore: non_constant_identifier_names
  //     required add_delete_update_post add_delete_update_post}) async {
  //   if (await connection.isConnected) {
  //     // ignore: await_only_futures
  //     await add_delete_update_post;
  //     return const Right(unit);
  //   } else {
  //     return Left(InternetFailure());
  //   }
  // }

  @override
  Future<Either<Failure, List<BannerData>>> getbanner() async {
    if (await connection.isConnected) {
      try {
        return Right(await remote.getbanner());
      } on ApiException {
        return Left(ApiFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getcategories() async {
    if (await connection.isConnected) {
      try {
        return Right(await remote.getcategories());
      } on ApiException {
        return Left(ApiFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, List<InsideData>>> getcategory(
      {required int id}) async {
    if (await connection.isConnected) {
      try {
        return Right(await remote.getcategory(id: id));
      } on ApiException {
        return Left(ApiFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntiy>> getuserdata() async {
    if (await connection.isConnected) {
      try {
        final token = await localAuth.getcashedtoken();
        try {
          final res = await remote.getuserdata(token: token);
          return Right(res);
        } on ApiException {
          return Left(ApiFailure());
        }
      } on CashException {
        return Left(CashFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }
}
