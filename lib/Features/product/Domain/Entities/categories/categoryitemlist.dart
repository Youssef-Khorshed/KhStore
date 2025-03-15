// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:store/Features/product/Data/models/product/outsideprodunctmodel.dart';

class CategoryItemList extends Equatable {
  bool? status;
  Null message;
  OutSideProductModel? data;

  CategoryItemList(
      {required this.status, required this.message, required this.data});

  @override
  List<Object?> get props => [status, message, data];
}
