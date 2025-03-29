import 'package:store/Features/product/Domain/Entities/product/insidedata.dart';

// ignore: must_be_immutable
class InSideProductModel extends InsideData {
  InSideProductModel(
      {required super.id,
      required super.price,
      required super.oldPrice,
      required super.discount,
      required super.image,
      required super.name,
      required super.description,
      required super.images,
      required super.inFavorites,
      required super.inCart});
  static InSideProductModel fromJson(Map<String, dynamic> json) {
    List<dynamic> imgs = json['images'] ?? [];
    final images = imgs.map((e) => e.toString()).toList();
    return InSideProductModel(
        id: json['id'],
        price: json['price'],
        oldPrice: json['old_price'],
        discount: json['discount'],
        image: json['image'],
        name: json['name'],
        description: json['description'],
        images: images,
        inFavorites: json['in_favorites'],
        inCart: json['in_cart']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'old_price': oldPrice,
      'discount': discount,
      'image': image,
      'name': name,
      'description': description,
      'images': images,
      'in_favorites': inFavorites,
      'in_cart': inCart,
    };
  }
}
