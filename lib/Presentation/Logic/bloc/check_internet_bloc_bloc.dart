// ignore_for_file: unrelated_type_equality_checks

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
part 'check_internet_bloc_event.dart';
part 'check_internet_bloc_state.dart';

class CheckInternetBlocBloc
    extends Bloc<CheckInternetBlocEvent, CheckInternetBlocState> {
  StreamSubscription? connectivity;
  ConnectivityResult? chekfirsttime;
  final case1 = ConnectivityResult.wifi;
  final case2 = ConnectivityResult.mobile;
  final case3 = ConnectivityResult.none;
  CheckInternetBlocBloc() : super(CheckInternetBlocInitial()) {
    on<CheckInternetBlocEvent>(checkconnection);
    on<CheckInternetFirstTimeEvent>(checkfirsttime);
    connectivity = Connectivity().onConnectivityChanged.listen((event) {
      if (event == case1 || event == case2) {
        add(ConnectedEvent());
      } else {
        add(NotConnectedEvent());
      }
    });
  }

  FutureOr<void> checkconnection(
      CheckInternetBlocEvent event, Emitter<CheckInternetBlocState> emit) {
    if (event is ConnectedEvent) {
      emit(ConnectedState());
    } else if (event is NotConnectedEvent) {
      emit(NoInternetdState());
    }
  }

  @override
  Future<void> close() {
    connectivity!.cancel();
    return super.close();
  }

  FutureOr<void> checkfirsttime(CheckInternetFirstTimeEvent event,
      Emitter<CheckInternetBlocState> emit) async {
    var chekfirsttime = await (Connectivity().checkConnectivity());
    print('chekfirsttime $chekfirsttime');
    if (chekfirsttime == case3) {
      emit(NoInternetdState());
    }
  }
}
