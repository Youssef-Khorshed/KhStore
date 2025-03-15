import 'package:store/Features/product/Data/models/categories/categories.dart';
import 'package:store/Features/product/Domain/Entities/categories/categorylist.dart';

// ignore: must_be_immutable
class CategoryListModel extends CategoryList {
  CategoryListModel(
      {required super.status, required super.message, required super.data});

  factory CategoryListModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> value = json['data']['data'];
    final data = value.map((item) => CategoryModel.fromJson(item)).toList();
    return CategoryListModel(
        status: json['status'], message: json['message'], data: data);
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data!.cast<CategoryModel>().map((v) => v.toJson()).toList(),
    };
  }
}
