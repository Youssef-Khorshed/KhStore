part of 'fav_bloc.dart';

abstract class FavEvent extends Equatable {
  const FavEvent();
  @override
  List<Object> get props => [];
}

class AddToFav extends FavEvent {
  int productid;
  AddToFav({required this.productid});
  @override
  List<Object> get props => [];
}

class GetToFav extends FavEvent {
  int? productid;
  GetToFav({required this.productid});
  @override
  List<Object> get props => [productid ?? 0];
}
