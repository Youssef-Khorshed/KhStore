import 'package:store/Features/cart/data/model/DataModel.dart';

import '../../domain/entity/Carts.dart';

class CartsModel extends Carts {
  CartsModel(
      {required super.status, required super.message, required super.data});

  factory CartsModel.fromJson(Map<String, dynamic> json) {
    return CartsModel(
        data: DataModel.fromJson(json['data']),
        status: json['status'],
        message: json['message']);
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data!.toJson(),
    };
  }
}
