import 'package:store/Features/product/Data/models/banner/bannerModel.dart';
import 'package:store/Features/product/Domain/Entities/banner/bannerlist.dart';

// ignore: must_be_immutable
class BannerListModel extends BannerList {
  BannerListModel(
      {required super.status, required super.message, required super.data});

  factory BannerListModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> value = json['data'];
    final data = value.map((item) => BannerModel.fromJson(item)).toList();
    return BannerListModel(
        status: json['status'], message: json['message'], data: data);
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data!.cast<BannerModel>().map((v) => v.toJson()).toList(),
    };
  }
}
