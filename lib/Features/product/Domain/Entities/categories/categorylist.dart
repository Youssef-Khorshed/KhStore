import 'package:equatable/equatable.dart';
import 'package:store/Features/product/Data/models/categories/categories.dart';

class CategoryList extends Equatable {
  bool? status;
  Null message;
  List<CategoryModel>? data;

  CategoryList(
      {required this.status, required this.message, required this.data});

  @override
  List<Object?> get props => [status, message, data];
}
