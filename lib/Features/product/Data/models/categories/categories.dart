import 'package:store/Features/product/Domain/Entities/categories/Categoty.dart';

class CategoryModel extends Category {
  const CategoryModel(
      {required super.id, required super.name, required super.image});

  // from json
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        id: json['id'], name: json['name'], image: json['image']);
  }
  // to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}
