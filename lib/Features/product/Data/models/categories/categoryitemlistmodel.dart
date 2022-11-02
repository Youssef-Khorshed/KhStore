import 'package:store/Features/product/Data/models/product/outsideprodunctmodel.dart';
import 'package:store/Features/product/Domain/Entities/categories/categoryitemlist.dart';

// ignore: must_be_immutable
class CategoryItemListModel extends CategoryItemList {
  CategoryItemListModel(
      {required super.status, required super.message, required super.data});

  factory CategoryItemListModel.fromJson(Map<String, dynamic> json) {
    return CategoryItemListModel(
        status: json['status'],
        message: json['message'],
        data: OutSideProductModel.fromJson(json['data']));
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data!,
    };
  }
}
