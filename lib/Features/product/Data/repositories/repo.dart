import 'package:store/Core/exception.dart';
import 'package:store/Core/internet.dart';
import 'package:store/Features/product/Data/datasources/local.dart';
import 'package:store/Features/product/Data/datasources/remote.dart';
import 'package:store/Features/product/Data/models/product/products.dart';
import 'package:store/Core/error.dart';
import 'package:dartz/dartz.dart';
import 'package:store/Features/product/Domain/Entities/banner/banner.dart';
import 'package:store/Features/product/Domain/Entities/categories/Categoty.dart';
import 'package:store/Features/product/Domain/Entities/product/insidedata.dart';
import 'package:store/Features/product/Domain/Repositories/product.dart';

import '../../Domain/Entities/product/products.dart';

typedef Future<Unit> add_delete_update_post();

class ProductRepoImp extends ProductRepo {
  RemoteDataSource remote;
  LocalDataSource local;
  NetworkInfo connection;
  ProductRepoImp(
      {required this.local, required this.remote, required this.connection});
  // @override
  // Future<Either<Failure, Unit>> addproduct({required Product product}) async {
  //   final productModel = ProductModel(
  //       status: product.status, message: product.message, data: product.data);

  //   return method(
  //       add_delete_update_post: () => remote.addproduct(product: productModel));
  // }

  // @override
  // Future<Either<Failure, Unit>> deleteproduct({required int id}) {
  //   return method(add_delete_update_post: () => remote.deleteproduct(id: id));
  // }

  // @override
  // Future<Either<Failure, Unit>> updateproduct({required Product product}) {
  //   final productModel = ProductModel(
  //       status: product.status, message: product.message, data: product.data);

  //   return method(
  //       add_delete_update_post: () =>
  //           remote.updateproduct(product: productModel));
  // }

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
  Future<Either<Failure, List<Banner>>> getbanner() async {
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
}
