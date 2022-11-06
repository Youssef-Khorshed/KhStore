part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();
}

class CartInitial extends CartState {
  @override
  List<Object?> get props => [];
}

class LoadingCart extends CartState {
  @override
  List<Object?> get props => [];
}

class GetCartSuccess extends CartState {
  Carts items;
  GetCartSuccess({required this.items});
  @override
  List<Object?> get props => [items];
}

class GetCartFail extends CartState {
  String message;
  GetCartFail({required this.message});
  @override
  List<Object?> get props => [message];
}

class AddRemoveUpdateCartFail extends CartState {
  String message;
  AddRemoveUpdateCartFail({required this.message});
  @override
  List<Object?> get props => [message];
}

class AddRemoveUpdateCartSuccess extends CartState {
  String message;
  AddRemoveUpdateCartSuccess({required this.message});
  @override
  List<Object?> get props => [message];
}
