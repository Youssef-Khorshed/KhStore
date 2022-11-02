import 'package:equatable/equatable.dart';
import 'package:store/Features/cart/data/model/CartModel.dart';

class Data extends Equatable {
  List<CartItemsModel>? cartItems;
  dynamic subTotal;
  dynamic total;

  Data({required this.cartItems, required this.subTotal, required this.total});

  @override
  List<Object?> get props => [cartItems, subTotal, total];
}
