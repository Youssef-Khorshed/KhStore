import 'package:equatable/equatable.dart';

import 'Categoty.dart';

// ignore: must_be_immutable
class Product extends Equatable {
  final int id;
  final String title;
  final int price;
  final String description;
  final Category category;
  final List<String> images;

  const Product(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.images});

  @override
  List<Object?> get props => [id, title, price, description, category, images];
}
