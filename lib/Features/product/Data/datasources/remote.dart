import 'package:dio/dio.dart';
import 'package:store/Core/exception.dart';
import 'package:store/Core/strings.dart';
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
}

class RemoteDataSourceImp extends RemoteDataSource {
  Dio dio;
  RemoteDataSourceImp({required this.dio});
 
  @override
  Future<List<InSideProductModel>> getAllproducts() async {
    final response = await Dio().get('${baseUrl}products',
        options: Options(headers: headers, receiveDataWhenStatusError: true));
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
        options: Options(headers: headers, receiveDataWhenStatusError: true));
    if (response.statusCode == 200) {
      final value = CategoryListModel.fromJson(response.data);
      return Future.value(value.data!);
    } else {
      throw ApiException();
    }
  }

  @override
  Future<List<BannerModel>> getbanner() async {
    final response = await Dio().get('${baseUrl}banners',
        options: Options(headers: headers, receiveDataWhenStatusError: true));
    if (response.statusCode == 200) {
      final value = BannerListModel.fromJson(response.data);
      return Future.value(value.data!);
    } else {
      throw ApiException();
    }
  }

  @override
  Future<List<InSideProductModel>> getcategory({required int id}) async {
    final response = await Dio().get('${baseUrl}categories/$id',
        options: Options(headers: headers, receiveDataWhenStatusError: true));
    if (response.statusCode == 200) {
      final value = CategoryItemListModel.fromJson(response.data);
      return Future.value(value.data!.data);
    } else {
      throw ApiException();
    }
  }

  // @override
  // Future<Unit> updateproduct({required ProductModel product}) async {
  //   final response = await Dio().put('${baseUrl}products/$id',
  //       queryParameters: {
  //         "title": product.title,
  //         "price": product.price,
  //         "description": product.description,
  //         "categoryId": product.category.id,
  //         "images": product.images
  //       },
  //       options: Options(headers: headers, receiveDataWhenStatusError: true));
  //   return method(response: response, code: 200);
  // }

  // Future<Unit> method(
  //     {required Response<dynamic> response, required int code}) {
  //   if (response.statusCode != code) {
  //     throw ApiException();
  //   } else {
  //     return Future.value(unit);
  //   }
  // }
}
