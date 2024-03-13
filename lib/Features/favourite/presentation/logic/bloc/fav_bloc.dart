import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:store/Core/getFailure.dart';
import 'package:store/Features/favourite/domain/entity/favEntity.dart';
import 'package:store/Features/favourite/domain/usecase/addfav.dart';
import '../../../domain/entity/favInsideData.dart';
import '../../../domain/usecase/getfav.dart';

part 'fav_event.dart';
part 'fav_state.dart';

class FavBloc extends Bloc<FavEvent, FavState> {
  AddTofavUsecase addTofavUsecase;
  GetFavUseCase getFavUseCase;
  FavEntity? favEntity;
  bool fav = false;
  List<FavInsideData> favdata = [];
  FavBloc({required this.addTofavUsecase, required this.getFavUseCase})
      : super(FavInitial()) {
    on<FavEvent>;
    on<AddToFav>(addtofav);
    on<GetToFav>(getfromfav);
  }

  FutureOr<void> addtofav(AddToFav event, Emitter<FavState> emit) async {
    emit(FavLoadingState());
    final value = await addTofavUsecase.call(productid: event.productid);
    value.fold((fail) {
      emit(AddToFavFailState(message: getfailure(failure: fail)));
    }, (message) {
      emit(AddToFavSuccessState(message: message));
      add(GetToFav(productid: event.productid));
    });
  }

  FutureOr<void> getfromfav(GetToFav event, Emitter<FavState> emit) async {
    favEntity = null;
    favdata.clear();
    emit(FavLoadingState());
    final value = await getFavUseCase.call();
    value.fold((failure) {
      emit(GetFavFailState(message: getfailure(failure: failure)));
    }, (entity) {
      favEntity = entity;
      favdata = entity.data!.data!;
      if (event.productid != null) {
        for (var element in favdata) {
          if (element.product!.id == event.productid) {
            fav = true;
            break;
          } else {
            fav = false;
          }
        }
        if (favdata.isEmpty) {
          fav = false;
        }
      }

      emit(GetFavSuccessState(favEntity: favEntity));
    });
  }
}
