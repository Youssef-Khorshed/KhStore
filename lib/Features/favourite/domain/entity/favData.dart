import 'package:equatable/equatable.dart';

import '../../Data/Model/favInsideData.dart';

class FavData extends Equatable {
  List<FavInsideDataModel>? data;

  FavData({
    required this.data,
  });

  @override
  List<Object?> get props => [data];
}
