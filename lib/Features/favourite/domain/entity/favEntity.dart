import 'package:equatable/equatable.dart';
import 'package:store/Features/favourite/Data/Model/favDataModel.dart';

import 'favData.dart';

class FavEntity extends Equatable {
  bool? status;
  String? message;
  FavDataModel? data;

  FavEntity({required this.status, required this.message, required this.data});

  @override
  List<Object?> get props => [status, message, data];
}
