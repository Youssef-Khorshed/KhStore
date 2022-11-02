import 'package:store/Features/cart/domain/entity/cartEntity.dart';

import '../../../product/Domain/Entities/product/insidedata.dart';

class CartItemsModel extends CartItems {
  CartItemsModel(
      {required super.id, required super.quantity, required super.product});

  factory CartItemsModel.fromJson(Map<String, dynamic> json) {
    return CartItemsModel(
        id: json['id'], quantity: json['quantity'], product: json['product']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
      //  'product': product!.toJson(),
    };
  }
}
