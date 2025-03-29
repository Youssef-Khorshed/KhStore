import 'package:equatable/equatable.dart';

import '../../../product/Data/models/product/insideprodunctmodel.dart';

// ignore: must_be_immutable
class CartItems extends Equatable {
  int? id;
  int? quantity;
  InSideProductModel? product;

  CartItems({required this.id, required this.quantity, required this.product});

  @override
  List<Object?> get props => [id, quantity, product];
}
