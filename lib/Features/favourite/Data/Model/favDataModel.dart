import 'package:store/Features/favourite/Data/Model/favInsideData.dart';
import 'package:store/Features/favourite/domain/entity/favData.dart';

// ignore: must_be_immutable
class FavDataModel extends FavData {
  FavDataModel({required super.data});

  factory FavDataModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> itm = json['data'];
    final data = itm.map((e) => FavInsideDataModel.fromJson(e)).toList();
    return FavDataModel(data: data);
  }

  Map<String, dynamic> toJson() {
    return {'data': data!.map((e) => e.toJson()).toList()};
  }
}
