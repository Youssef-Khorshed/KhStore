import 'dart:convert';

import 'package:store/Features/product/Data/models/product/outsideprodunctmodel.dart';
import 'package:store/Features/product/Domain/Entities/product/products.dart';

// ignore: must_be_immutable
class ProductModel extends Product {
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        status: json['status'],
        message: json['message'],
        data: OutSideProductModel.fromJson(json['data']));
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'data': jsonEncode(data)};
  }

  ProductModel(
      {required super.status, required super.message, required super.data});
}
