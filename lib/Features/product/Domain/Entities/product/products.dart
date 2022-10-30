import 'package:equatable/equatable.dart';
import 'package:store/Features/product/Data/models/product/outsideprodunctmodel.dart';

// ignore: must_be_immutable
class Product extends Equatable {
  bool? status;
  String? message;
  OutSideProductModel? data;

  Product({required this.status, required this.message, required this.data});

  @override
  List<Object?> get props => [status, message, data];
}
