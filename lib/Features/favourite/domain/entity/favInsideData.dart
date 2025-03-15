import 'package:equatable/equatable.dart';

import '../../../product/Data/models/product/insideprodunctmodel.dart';

class FavInsideData extends Equatable {
  int? id;
  InSideProductModel? product;

  FavInsideData({required this.id, required this.product});

  @override
  List<Object?> get props => [id, product];
}
