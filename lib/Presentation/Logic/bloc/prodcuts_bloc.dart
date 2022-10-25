// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:store/Core/error.dart';
import 'package:store/Core/strings.dart';
import 'package:store/Domain/Entities/products.dart';
import 'package:store/Domain/UseCases/addproduct.dart';
import 'package:store/Domain/UseCases/deleteproduct.dart';
import 'package:store/Domain/UseCases/getProducts.dart';
import 'package:store/Domain/UseCases/updateproduct.dart';
part 'prodcuts_event.dart';
part 'prodcuts_state.dart';

class ProdcutsBloc extends Bloc<ProdcutsEvent, ProdcutsState> {
  GetproductUsecase getproductUsecase;
  AddproductUsecase addproductUsecase;
  UpdateproductUsecase updateproductUsecase;
  DeleteproductUsecase deleteproductUsecase;
  ProdcutsBloc(
      {required this.getproductUsecase,
      required this.addproductUsecase,
      required this.deleteproductUsecase,
      required this.updateproductUsecase})
      : super(ProdcutsInitial()) {
    on<AddProductEvent>(addproduct);
    on<DeleteProductEvent>(deleteproduct);
    on<UpdateProductEvent>(updateprodcuts);
    on<GetProdcutsEvent>(getproducts);
  }

  FutureOr<void> deleteproduct(
      DeleteProductEvent event, Emitter<ProdcutsState> emit) async {
    emit(LoadingProducts());
    final value = await deleteproductUsecase.call(product: event.id);
    emit(add_Delete_Update_products_state(
        value: value, message: productDeletedSuccess));
  }

  FutureOr<void> addproduct(
      AddProductEvent event, Emitter<ProdcutsState> emit) async {
    emit(LoadingProducts());
    final value = await addproductUsecase.call(product: event.product);
    emit(add_Delete_Update_products_state(
        value: value, message: productAddedSuccess));
  }

  FutureOr<void> updateprodcuts(
      UpdateProductEvent event, Emitter<ProdcutsState> emit) async {
    emit(LoadingProducts());
    final value = await updateproductUsecase.call(product: event.product);
    emit(add_Delete_Update_products_state(
        value: value, message: productUpdatedSuccess));
  }

  FutureOr<void> getproducts(
      GetProdcutsEvent event, Emitter<ProdcutsState> emit) async {
    emit(LoadingProducts());
    final value = await getproductUsecase.call();
    emit(get_products_state(value: value, message: productGetSuccess));
  }

  getfailure({required Failure failure}) {
    switch (failure.runtimeType) {
      case CashFailure:
        apifailure;
        break;
      case InternetFailure:
        internetfailure;
        break;
      case ApiFailure:
        apifailure;
        break;
      default:
        unexpectedfailure;
    }
  }

  ProdcutsState add_Delete_Update_products_state(
      {required Either<Failure, Unit> value, required String message}) {
    return value.fold(
        (failure) => Add_Update_Delete_ProductFail(
            message: getfailure(failure: failure)),
        (r) => Add_Update_Delete_ProductSuccess(message: message));
  }

  ProdcutsState get_products_state(
      {required Either<Failure, List<Product>> value,
      required String message}) {
    return value.fold(
        (failure) => GetProdcutsFail(message: getfailure(failure: failure)),
        (products) => GetProdcutsSuccess(products: products, message: message));
  }
}
