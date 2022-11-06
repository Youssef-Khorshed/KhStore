import 'package:dio/dio.dart';
import 'package:store/Features/cart/data/model/CartModel.dart';
import 'package:store/Features/cart/data/model/CartsModel.dart';
import '../../../../Core/exception.dart';
import '../../../../Core/strings.dart';

abstract class CartRemote {
  Future<String> addToCart(
      {required int productid, required int quantity, required String token});
  Future<String> removeFromCart(
      {required int cartItemId, required String token});
  Future<String> updateCart(
      {required int cartItemId, required String token, required int qunatity});
  Future<CartsModel> getcart({required String token});
}

class CartRemoteImp extends CartRemote {
  Dio dio;
  CartRemoteImp({required this.dio});
  @override
  Future<String> addToCart(
      {required int productid,
      required int quantity,
      required String token}) async {
    final response = await dio.post('${baseUrl}carts',
        data: {"product_id": productid, "quantity": quantity},
        options: Options(
            headers: headers(token: token), receiveDataWhenStatusError: true));
    if (response.statusCode == 200) {
      final value = response.data['message'];
      return Future.value(value);
    } else {
      throw ApiException();
    }
  }

  @override
  Future<CartsModel> getcart({required String token}) async {
    final response = await dio.get('${baseUrl}carts',
        options: Options(
            headers: headers(token: token), receiveDataWhenStatusError: true));
    if (response.statusCode == 200) {
      final value = CartsModel.fromJson(response.data);
      return Future.value(value);
    } else {
      throw ApiException();
    }
  }

  @override
  Future<String> removeFromCart(
      {required int cartItemId, required String token}) async {
    final response = await dio.delete('${baseUrl}carts',
        options: Options(
            headers: headers(token: token), receiveDataWhenStatusError: true));
    if (response.statusCode == 200) {
      final value = response.data['message'];
      return Future.value(value);
    } else {
      throw ApiException();
    }
  }

  @override
  Future<String> updateCart(
      {required int cartItemId,
      required String token,
      required int qunatity}) async {
    final response = await dio.put('${baseUrl}carts',
        data: {"quantity": qunatity},
        options: Options(
            headers: headers(token: token), receiveDataWhenStatusError: true));
    if (response.statusCode == 200) {
      final value = response.data['message'];
      return Future.value(value);
    } else {
      throw ApiException();
    }
  }
}
