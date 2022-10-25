import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:store/Core/exception.dart';
import 'package:store/Core/strings.dart';
import 'package:store/Data/models/products.dart';

abstract class RemoteDataSource {
  Future<Unit> addproduct({required ProductModel product});
  Future<List<ProductModel>> getAllproducts();
  Future<Unit> updateproduct({required ProductModel product});
  Future<Unit> deleteproduct({required int id});
}

class RemoteDataSourceImp extends RemoteDataSource {
  Dio dio;
  RemoteDataSourceImp({required this.dio});
  @override
  Future<Unit> addproduct({required ProductModel product}) async {
    final response = await Dio().post('${baseUrl}products/',
        options: Options(headers: headers, receiveDataWhenStatusError: true),
        queryParameters: {
          "title": product.title,
          "price": product.price,
          "description": product.description,
          "categoryId": product.category.id,
          "images": product.images
        });
    return method(response: response, code: 201);
  }

  @override
  Future<Unit> deleteproduct({required int id}) async {
    final response = await Dio().delete('${baseUrl}products/$id',
        options: Options(headers: headers, receiveDataWhenStatusError: true));

    return method(response: response, code: 200);
  }

  @override
  Future<List<ProductModel>> getAllproducts() async {
    final response = await Dio().get('${baseUrl}products',
        options: Options(headers: headers, receiveDataWhenStatusError: true));
    if (response.statusCode == 200) {
      List<dynamic> value = response.data;
      List<ProductModel> res =
          value.map((e) => ProductModel.fromJson(json: e)).toList();
      return Future.value(res);
    } else {
      throw ApiException();
    }
  }

  @override
  Future<Unit> updateproduct({required ProductModel product}) async {
    final response = await Dio().put('${baseUrl}products/$id',
        queryParameters: {
          "title": product.title,
          "price": product.price,
          "description": product.description,
          "categoryId": product.category.id,
          "images": product.images
        },
        options: Options(headers: headers, receiveDataWhenStatusError: true));
    return method(response: response, code: 200);
  }

  Future<Unit> method(
      {required Response<dynamic> response, required int code}) {
    if (response.statusCode != code) {
      throw ApiException();
    } else {
      return Future.value(unit);
    }
  }
}
