// ignore: file_names

import '../../../product/Data/models/product/insideprodunctmodel.dart';
import '../../domain/entity/favInsideData.dart';

class FavInsideDataModel extends FavInsideData {
  FavInsideDataModel({required super.id, required super.product});

  factory FavInsideDataModel.fromJson(Map<String, dynamic> json) {
    return FavInsideDataModel(
        id: json['id'], product: InSideProductModel.fromJson(json['product']));
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'product': product!.toJson()};
  }
}
