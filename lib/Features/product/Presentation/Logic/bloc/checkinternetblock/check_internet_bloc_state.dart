part of 'check_internet_bloc_bloc.dart';

abstract class CheckInternetBlocState extends Equatable {
  const CheckInternetBlocState();

  @override
  List<Object> get props => [];
}

class CheckInternetBlocInitial extends CheckInternetBlocState {}

class ConnectedState extends CheckInternetBlocState {}

class NoInternetdState extends CheckInternetBlocState {}
