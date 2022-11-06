import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/Core/exception.dart';
import 'package:store/Core/strings.dart';
import 'package:store/Features/cart/data/model/CartModel.dart';

abstract class CartLocal {
  Future<List<CartItemsModel>> getcashedcart({required String key});
  Future<Unit> setcashedcart({required List<CartItemsModel> items});
}

class CartLocalImp extends CartLocal {
  SharedPreferences sharedPreferences;
  CartLocalImp({required this.sharedPreferences});
  @override
  Future<List<CartItemsModel>> getcashedcart({required String key}) {
    final item = sharedPreferences.getString(cartkey);
    if (item != null) {
      final items = json.decode(item!);
      final res = items.map((e) => CartItemsModel.fromJson(e)).toList();
      return Future.value(res);
    } else {
      throw CashException();
    }
  }

  @override
  Future<Unit> setcashedcart({required List<CartItemsModel> items}) {
    final res = items.map((e) => e.toJson()).toList();
    sharedPreferences.setString(cartkey, json.encode(res));
    return Future.value(unit);
  }
}
