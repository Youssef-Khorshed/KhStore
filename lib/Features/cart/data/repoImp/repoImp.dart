import 'package:store/Core/internet.dart';
import 'package:store/Core/strings.dart';
import 'package:store/Features/auth/Data/DataSource/local.dart';
import 'package:store/Features/cart/data/datasource/local.dart';
import 'package:store/Features/cart/data/datasource/remote.dart';
import 'package:store/Features/cart/domain/entity/Carts.dart';
import 'package:store/Features/cart/domain/entity/cartEntity.dart';
import 'package:store/Core/error.dart';
import 'package:dartz/dartz.dart';
import 'package:store/Features/cart/domain/repo/repo.dart';

import '../../../../Core/exception.dart';

class CartRepoImp extends CartRepo {
  CartLocal cartLocal;
  CartRemote cartRemote;
  NetworkInfo connection;
  LocalAuth localAuth;
  CartRepoImp(
      {required this.cartLocal,
      required this.cartRemote,
      required this.connection,
      required this.localAuth});
  @override
  Future<Either<Failure, String>> addToCart(
      {required int productid, required int quantity}) async {
    if (await connection.isConnected) {
      try {
        final token = await localAuth.getcashedtoken();
        try {
          final res = await cartRemote.addToCart(
              token: token, productid: productid, quantity: quantity);
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

  @override
  Future<Either<Failure, Carts>> getcart() async {
    if (await connection.isConnected) {
      try {
        final token = await localAuth.getcashedtoken();
        try {
          final res = await cartRemote.getcart(token: token);
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

  @override
  Future<Either<Failure, String>> removeFromCart(
      {required int cartItemId}) async {
    if (await connection.isConnected) {
      try {
        final token = await localAuth.getcashedtoken();
        try {
          final res = await cartRemote.removeFromCart(
              token: token, cartItemId: cartItemId);
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

  @override
  Future<Either<Failure, String>> updateCart(
      {required int cartItemId, required int quantity}) async {
    if (await connection.isConnected) {
      try {
        final token = await localAuth.getcashedtoken();
        try {
          final res = await cartRemote.updateCart(
              token: token, cartItemId: cartItemId, qunatity: quantity);
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
