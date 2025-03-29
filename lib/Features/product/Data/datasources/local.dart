import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/Core/exception.dart';
import 'package:store/Core/strings.dart';

import '../models/product/insideprodunctmodel.dart';

abstract class LocalDataSource {
  Future<List<InSideProductModel>> getProducts();
  Future<Unit> cashproducts({required List<InSideProductModel> products});
}

class LocalDataSourceImp extends LocalDataSource {
  final SharedPreferences sharedPreferences;
  LocalDataSourceImp({required this.sharedPreferences});
  @override
  Future<Unit> cashproducts({required List<InSideProductModel> products}) {
    List<Map<String, dynamic>> val = [];
    for (var element in products) {
      val.add(element.toJson());
    }
    sharedPreferences.setString(cashedProducts, json.encode(val));
    return Future.value(unit);
  }

  @override
  Future<List<InSideProductModel>> getProducts() {
    final source = sharedPreferences.getString(cashedProducts);
    if (source != null) {
      final value = json.decode(source);
      List<InSideProductModel> res =
          value.data!.data!.cast<InSideProductModel>();
      return Future.value(res);
    } else {
      throw CashException();
    }
  }
}
