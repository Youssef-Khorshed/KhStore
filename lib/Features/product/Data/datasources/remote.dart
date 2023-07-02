import 'dart:io';

import 'package:dio/dio.dart';
import 'package:store/Core/exception.dart';
import 'package:store/Core/strings.dart';
import 'package:store/Features/auth/Data/Model/usermodel.dart';
import 'package:store/Features/product/Data/models/banner/bannerModel.dart';
import 'package:store/Features/product/Data/models/banner/bannerlistmodel.dart';
import 'package:store/Features/product/Data/models/categories/categories.dart';
import 'package:store/Features/product/Data/models/categories/categoryitemlistmodel.dart';
import 'package:store/Features/product/Data/models/categories/categorylistmodel.dart';
import 'package:store/Features/product/Data/models/product/insideprodunctmodel.dart';
import 'package:store/Features/product/Data/models/product/products.dart';

abstract class RemoteDataSource {
  Future<List<CategoryModel>> getcategories();
  Future<List<InSideProductModel>> getAllproducts();
  Future<List<BannerModel>> getbanner();
  Future<List<InSideProductModel>> getcategory({required int id});
  Future<UserModel> getuserdata({required String token});
}

class RemoteDataSourceImp extends RemoteDataSource {
  Dio dio;
  RemoteDataSourceImp({required this.dio});

  @override
  Future<List<InSideProductModel>> getAllproducts() async {
    final response = await Dio().get('${baseUrl}products',
        options: Options(headers: headers(), receiveDataWhenStatusError: true));
    if (response.statusCode == 200) {
      final value = ProductModel.fromJson(response.data);
      return Future.value(value.data!.data);
    } else {
      throw ApiException();
    }
  }

  @override
  Future<List<CategoryModel>> getcategories() async {
    final response = await Dio().get('${baseUrl}categories',
        options: Options(headers: headers(), receiveDataWhenStatusError: true));
    if (response.statusCode == 200) {
      final value = CategoryListModel.fromJson(response.data);
      return Future.value(value.data!);
    } else {
      throw ApiException();
    }
  }

  @override
  Future<List<BannerModel>> getbanner() async {
    try {
      String api = Uri.parse('${baseUrl}banners').toString();
      final response = await Dio().get(api,
          options:
              Options(headers: headers(), receiveDataWhenStatusError: false));
      if (response.statusCode == 200) {
        final value = BannerListModel.fromJson(response.data);
        for (int i = 0; i < value.data!.length; i++) {
          value.data![i].image = bannerimages[i];
        }
        return Future.value(value.data!);
      } else {
        throw ApiException();
      }
    } on HttpException catch (err) {
      print('eee');
      throw ApiException();
    }
  }

  @override
  Future<List<InSideProductModel>> getcategory({required int id}) async {
    final response = await Dio().get('${baseUrl}categories/$id',
        options: Options(headers: headers(), receiveDataWhenStatusError: true));
    if (response.statusCode == 200) {
      final value = CategoryItemListModel.fromJson(response.data);
      return Future.value(value.data!.data);
    } else {
      throw ApiException();
    }
  }

  @override
  Future<UserModel> getuserdata({required String token}) async {
    final response = await Dio().get('${baseUrl}profile',
        options: Options(
            headers: headers(token: token), receiveDataWhenStatusError: true));
    if (response.statusCode == 200) {
      final value = UserModel.fromJson(response.data);
      return Future.value(value);
    } else {
      throw ApiException();
    }
  }
}
