import 'package:store/Features/favourite/Data/Model/favDataModel.dart';
import 'package:store/Features/favourite/domain/entity/favEntity.dart';

class FavModel extends FavEntity {
  FavModel(
      {required super.status, required super.message, required super.data});
  factory FavModel.fromJson(Map<String, dynamic> json) {
    return FavModel(
        data: FavDataModel.fromJson(json['data']),
        message: json['message'],
        status: json['status']);
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data!.toJson(),
    };
  }
}
