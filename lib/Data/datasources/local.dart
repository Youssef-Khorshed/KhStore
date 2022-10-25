import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/Core/exception.dart';
import 'package:store/Core/strings.dart';
import 'package:store/Data/models/products.dart';

abstract class LocalDataSource {
  Future<List<ProductModel>> getProducts();
  Future<Unit> cashproducts({required List<ProductModel> products});
}

class LocalDataSourceImp extends LocalDataSource {
  final SharedPreferences sharedPreferences;
  LocalDataSourceImp({required this.sharedPreferences});
  @override
  Future<Unit> cashproducts({required List<ProductModel> products}) {
    List<Map<String, dynamic>> val = [];
    for (var element in products) {
      val.add(element.toJson());
    }
    sharedPreferences.setString(cashedProducts, json.encode(val));
    return Future.value(unit);
  }

  @override
  Future<List<ProductModel>> getProducts() {
    List<ProductModel> products = [];
    final source = sharedPreferences.getString(cashedProducts);
    if (source != null) {
      List<Map<String, dynamic>> decoded = json.decode(source);
      for (var element in decoded) {
        products.add(ProductModel.fromJson(json: element));
      }
      return Future.value(products);
    } else {
      throw CashException();
    }
  }
}
