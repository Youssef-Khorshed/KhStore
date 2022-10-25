// ignore_for_file: must_be_immutable

part of 'prodcuts_bloc.dart';

abstract class ProdcutsEvent extends Equatable {
  const ProdcutsEvent();

  @override
  List<Object> get props => [];
}

class GetProdcutsEvent extends ProdcutsEvent {}

class AddProductEvent extends ProdcutsEvent {
  Product product;
  AddProductEvent({required this.product});
  @override
  List<Object> get props => [product];
}

class DeleteProductEvent extends ProdcutsEvent {
  int id;
  DeleteProductEvent({required this.id});
  @override
  List<Object> get props => [id];
}

class UpdateProductEvent extends ProdcutsEvent {
  Product product;
  UpdateProductEvent({required this.product});
  @override
  List<Object> get props => [product];
}
