// ignore_for_file: prefer_void_to_null

import 'package:equatable/equatable.dart';
import 'package:store/Core/strings.dart';

// ignore: must_be_immutable
class BannerData extends Equatable {
  int? id;
  String? image = error_image;
  dynamic category;
  Null product;

  BannerData(
      {required this.id,
      required this.image,
      required this.category,
      required this.product});

  @override
  List<Object?> get props => [
        id,
        image,
        category,
        product,
      ];
}
