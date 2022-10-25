// ignore_for_file: camel_case_types

part of 'prodcuts_bloc.dart';

abstract class ProdcutsState extends Equatable {}

class ProdcutsInitial extends ProdcutsState {
  @override
  List<Object?> get props => [];
}

class LoadingProducts extends ProdcutsState {
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class GetProdcutsSuccess extends ProdcutsState {
  List<Product> products;
  String message;
  GetProdcutsSuccess({required this.products, required this.message});
  @override
  List<Object?> get props => [products];
}

// ignore: must_be_immutable
class GetProdcutsFail extends ProdcutsState {
  String message;
  GetProdcutsFail({required this.message});
  @override
  List<Object?> get props => [message];
}

// ignore: must_be_immutable
class Add_Update_Delete_ProductSuccess extends ProdcutsState {
  String message;
  Add_Update_Delete_ProductSuccess({required this.message});
  @override
  List<Object?> get props => [message];
}

// ignore: must_be_immutable
class Add_Update_Delete_ProductFail extends ProdcutsState {
  String message;
  Add_Update_Delete_ProductFail({required this.message});
  @override
  List<Object?> get props => [message];
}
