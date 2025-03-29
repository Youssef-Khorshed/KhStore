// ignore: must_be_immutable
import '../../../product/Data/models/product/insideprodunctmodel.dart';
import '../../domain/entity/cartEntity.dart';

// ignore: must_be_immutable
class CartItemsModel extends CartItems {
  CartItemsModel(
      {required super.id, required super.quantity, required super.product});

  factory CartItemsModel.fromJson(Map<String, dynamic> json) {
    return CartItemsModel(
        id: json['id'],
        quantity: json['quantity'],
        product: InSideProductModel.fromJson(json['product']));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
      'product': product!.toJson(),
    };
  }
}
