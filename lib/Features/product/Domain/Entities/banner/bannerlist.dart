import 'package:equatable/equatable.dart';
import 'package:store/Features/product/Data/models/banner/bannerModel.dart';

import 'banner.dart';

class BannerList extends Equatable {
  bool? status;
  Null message;
  List<BannerModel>? data;

  BannerList({required this.status, required this.message, required this.data});

  @override
  List<Object?> get props => [status, message, data];
}
