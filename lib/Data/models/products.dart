import 'package:store/Data/models/categories.dart';
import 'package:store/Domain/Entities/products.dart';

// ignore: must_be_immutable
class ProductModel extends Product {
  const ProductModel(
      {required super.id,
      required super.title,
      required super.price,
      required super.description,
      required super.category,
      required super.images});

  factory ProductModel.fromJson({required Map<String, dynamic> json}) {
    return ProductModel(
        id: json['id'],
        title: json['title'],
        price: json['price'],
        description: json['description'],
        category: CategoryModel.fromJson(json['category']),
        images: json['images'].cast<String>());
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'images': images,
    };
  }
}
