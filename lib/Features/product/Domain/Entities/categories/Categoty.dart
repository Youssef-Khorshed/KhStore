// ignore: file_names
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Category extends Equatable {
  final int id;
  final String name;
  final String image;

  const Category({required this.id, required this.name, required this.image});

  @override
  List<Object?> get props => [id, name, image];
}
