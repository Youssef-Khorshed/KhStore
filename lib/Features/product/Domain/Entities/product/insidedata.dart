// ignore: must_be_immutable
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class InsideData extends Equatable {
  dynamic id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;
  List<String>? images;
  bool? inFavorites;
  bool? inCart;

  InsideData(
      {required this.id,
      required this.price,
      required this.oldPrice,
      required this.discount,
      required this.image,
      required this.name,
      required this.description,
      required this.images,
      required this.inFavorites,
      required this.inCart});

  @override
  List<Object?> get props => [
        id,
        price,
        oldPrice,
        discount,
        image,
        name,
        description,
        images,
        inFavorites,
        inCart
      ];
}
