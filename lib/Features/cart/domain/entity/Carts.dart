import 'package:equatable/equatable.dart';
import 'package:store/Features/cart/data/model/DataModel.dart';

class Carts extends Equatable {
  bool? status;
  String? message;
  DataModel? data;

  Carts({required this.status, required this.message, required this.data});

  @override
  List<Object?> get props => [message, data, status];
}
