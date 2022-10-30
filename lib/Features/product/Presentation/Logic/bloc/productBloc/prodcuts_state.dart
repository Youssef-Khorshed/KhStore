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
  List<InsideData> products;
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

class GetCategorySuccess extends ProdcutsState {
  List<InsideData> products;
  String message;
  GetCategorySuccess({required this.products, required this.message});
  @override
  List<Object?> get props => [products];
}

// ignore: must_be_immutable
class GetCategoryFail extends ProdcutsState {
  String message;
  GetCategoryFail({required this.message});
  @override
  List<Object?> get props => [message];
}

// ignore: must_be_immutable
class GetCategoriesSuccess extends ProdcutsState {
  List<Category> products;
  String message;
  GetCategoriesSuccess({required this.products, required this.message});
  @override
  List<Object?> get props => [products];
}

// ignore: must_be_immutable
class GetCategoriesFail extends ProdcutsState {
  String message;
  GetCategoriesFail({required this.message});
  @override
  List<Object?> get props => [message];
}

class GetBannerSuccess extends ProdcutsState {
  List<Banner> products;
  String message;
  GetBannerSuccess({required this.products, required this.message});
  @override
  List<Object?> get props => [products];
}

// ignore: must_be_immutable
class GetBannerFail extends ProdcutsState {
  String message;
  GetBannerFail({required this.message});
  @override
  List<Object?> get props => [message];
}

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

class UpdatedBannerIndexState extends ProdcutsState {
  int index;
  UpdatedBannerIndexState({required this.index});
  @override
  List<Object?> get props => [index];
}
