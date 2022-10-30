part of 'check_internet_bloc_bloc.dart';

abstract class CheckInternetBlocEvent extends Equatable {
  const CheckInternetBlocEvent();

  @override
  List<Object> get props => [];
}

class ConnectedEvent extends CheckInternetBlocEvent {}

class NotConnectedEvent extends CheckInternetBlocEvent {}

class CheckInternetFirstTimeEvent extends CheckInternetBlocEvent {}
