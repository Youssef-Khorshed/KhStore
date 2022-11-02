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

class GetCategoryEvent extends ProdcutsEvent {
  int id;
  String title;
  GetCategoryEvent({required this.id, required this.title});
  @override
  List<Object> get props => [id, title];
}

class GetCategoriesEvent extends ProdcutsEvent {
  @override
  List<Object> get props => [];
}

class GetBannerEvent extends ProdcutsEvent {
  @override
  List<Object> get props => [];
}

class GetUserDataEvent extends ProdcutsEvent {
  @override
  List<Object> get props => [];
}

class UpdateBannerIndextEvent extends ProdcutsEvent {
  int index;
  UpdateBannerIndextEvent({required this.index});
  @override
  List<Object> get props => [index];
}

class UpdateProductIndextEvent extends ProdcutsEvent {
  int index;
  UpdateProductIndextEvent({required this.index});
  @override
  List<Object> get props => [index];
}
