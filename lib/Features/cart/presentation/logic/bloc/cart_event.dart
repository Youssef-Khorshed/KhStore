part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddToCartEvent extends CartEvent {
  int quantity, productid;
  AddToCartEvent({required this.productid, required this.quantity});
  @override
  List<Object> get props => [productid, quantity];
}

class UpdateToCartEvent extends CartEvent {
  int quantity, productid;
  UpdateToCartEvent({required this.productid, required this.quantity});
  @override
  List<Object> get props => [productid, quantity];
}

class RemoveFromCartEvent extends CartEvent {
  int cartItemid;
  RemoveFromCartEvent({required this.cartItemid});
  @override
  List<Object> get props => [cartItemid];
}

class GetCartEvent extends CartEvent {
  int? productid;
  GetCartEvent({required this.productid});
  @override
  List<Object> get props => [productid ?? 0];
}
