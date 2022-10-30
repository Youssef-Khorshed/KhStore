import 'package:store/Features/product/Data/models/product/insideprodunctmodel.dart';
import '../../../Domain/Entities/product/outsidedata.dart';

// ignore: must_be_immutable
class OutSideProductModel extends OutSideData {
  OutSideProductModel({
    required super.currentPage,
    required super.data,
  });

  factory OutSideProductModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> rs = json['data'];
    final res = rs.map((e) => InSideProductModel.fromJson(e)).toList();
    return OutSideProductModel(
      currentPage: json['current_page'],
      data: res,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'data': data!.cast<InSideProductModel>().map((v) => v.toJson()).toList(),
    };
  }
}
