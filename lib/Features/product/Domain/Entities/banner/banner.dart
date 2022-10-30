// ignore_for_file: prefer_void_to_null

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Banner extends Equatable {
  int? id;
  String? image;
  Null category;
  Null product;

  Banner(
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
