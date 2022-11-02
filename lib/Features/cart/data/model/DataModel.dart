import 'package:store/Features/cart/domain/entity/Data.dart';

import 'CartModel.dart';

// ignore: must_be_immutable
class DataModel extends Data {
  DataModel(
      {required super.cartItems,
      required super.subTotal,
      required super.total});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> items = json['cart_items'];
    List<CartItemsModel> data =
        items.map((e) => CartItemsModel.fromJson(e)).toList();
    return DataModel(
        cartItems: data, subTotal: json['sub_total'], total: json['total']);
  }

  Map<String, dynamic> toJson() {
    return {
      'cart_items': cartItems!.map((v) => v.toJson()).toList(),
      'sub_total': subTotal,
      'total': total,
    };
  }
}
