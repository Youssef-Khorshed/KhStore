part of 'fav_bloc.dart';

abstract class FavState extends Equatable {
  const FavState();
}

class FavInitial extends FavState {
  @override
  List<Object?> get props => [];
}

class FavLoadingState extends FavState {
  @override
  List<Object?> get props => [];
}

class AddToFavSuccessState extends FavState {
  String message;
  AddToFavSuccessState({required this.message});
  @override
  List<Object?> get props => [message];
}

class AddToFavFailState extends FavState {
  String message;
  AddToFavFailState({required this.message});
  @override
  List<Object?> get props => [message];
}

class GetFavFailState extends FavState {
  String message;
  GetFavFailState({required this.message});
  @override
  List<Object?> get props => [message];
}

class GetFavSuccessState extends FavState {
  FavEntity? favEntity;
  GetFavSuccessState({required this.favEntity});
  @override
  List<Object?> get props => [favEntity];
}
