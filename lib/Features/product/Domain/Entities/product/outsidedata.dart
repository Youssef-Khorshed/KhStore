// ignore: must_be_immutable
import 'package:equatable/equatable.dart';
import 'package:store/Features/product/Data/models/product/insideprodunctmodel.dart';

// ignore: must_be_immutable
class OutSideData extends Equatable {
  int? currentPage;
  List<InSideProductModel>? data = [];

  OutSideData({
    required this.currentPage,
    required this.data,
  });

  @override
  List<Object?> get props => [
        currentPage,
        data,
      ];
}
