import 'package:store/Features/product/Domain/Entities/banner/banner.dart';

class BannerModel extends BannerData {
  BannerModel(
      {required super.id,
      required super.image,
      required super.category,
      required super.product});

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
      id: json['id'],
      image: json['image'],
      category: json['category'],
      product: json['product']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
        'category': category,
        'product': product,
      };
}
