// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:store/Core/error.dart';
import 'package:store/Core/strings.dart';
import 'package:store/Features/auth/Domain/Entity/user.dart';
import 'package:store/Features/product/Domain/Entities/categories/Categoty.dart';
import 'package:store/Features/product/Domain/Entities/banner/banner.dart';
import 'package:store/Features/product/Domain/Entities/product/insidedata.dart';
import 'package:store/Features/product/Domain/Entities/product/products.dart';
import 'package:store/Features/product/Domain/UseCases/getbanner.dart';
import 'package:store/Features/product/Domain/UseCases/getProducts.dart';
import 'package:store/Features/product/Domain/UseCases/getcategories.dart';
import 'package:store/Features/product/Domain/UseCases/getcategory.dart';
import 'package:store/Features/product/Domain/UseCases/getuserdata.dart';
import '../../../../../../Core/getFailure.dart';
part 'prodcuts_event.dart';
part 'prodcuts_state.dart';

class ProdcutsBloc extends Bloc<ProdcutsEvent, ProdcutsState> {
  GetproductUsecase getproductUsecase;
  GetCategoriesUseCase getCategoriesUseCase;
  GetBannerUseCase getBannerUseCase;
  GetCategoryUseCase categoryUseCase;
  UserDataUsecase userDataUsecase;
  List<Category> categories = [];
  List<InsideData> offerproducts = [];
  List<InsideData> some_offerproducts = [];
  List<InsideData> category_items = [];
  List<BannerData> banneritems = [];
  int bannerindex = 0;
  int productItemindex = 0;
  UserEntiy? userinfo;
  ProdcutsBloc(
      {required this.getproductUsecase,
      required this.getCategoriesUseCase,
      required this.getBannerUseCase,
      required this.categoryUseCase,
      required this.userDataUsecase})
      : super(ProdcutsInitial()) {
    on<GetProdcutsEvent>(getproducts);
    on<GetCategoryEvent>(getcategory);
    on<GetCategoriesEvent>(getcategories);
    on<GetBannerEvent>(getbanner);
    on<UpdateBannerIndextEvent>(updatebannerindex);
    on<UpdateProductIndextEvent>(updateproductindex);
    on<GetUserDataEvent>(getuserdata);
  }

  FutureOr<void> getproducts(
      GetProdcutsEvent event, Emitter<ProdcutsState> emit) async {
    emit(LoadingProducts());
    final value = await getproductUsecase.call();
    value.fold((failure) {
      emit(GetProdcutsFail(message: getfailure(failure: failure)));
    }, (products) {
      products.forEach((element) {
        if (element.discount > 0) {
          offerproducts.add(element);
        }
      });
      for (int i = 0; i < 6; i++) {
        some_offerproducts.add(offerproducts[i]);
      }
      emit(GetProdcutsSuccess(products: products, message: 'message'));
    });
  }

  ProdcutsState add_Delete_Update_products_state(
      {required Either<Failure, Unit> value, required String message}) {
    return value.fold(
        (failure) => Add_Update_Delete_ProductFail(
            message: getfailure(failure: failure)),
        (r) => Add_Update_Delete_ProductSuccess(message: message));
  }

  FutureOr<void> getbanner(
      GetBannerEvent event, Emitter<ProdcutsState> emit) async {
    emit(LoadingBanners());
    final value = await getBannerUseCase.call();
    print('======================banner list====================');
    print(value);
    print('======================banner list====================');

    value.fold((failure) {
      emit(GetBannerFail(message: getfailure(failure: failure)));
    }, (products) {
      banneritems.addAll(products);
      emit(GetBannerSuccess(products: products, message: 'message'));
    });
  }

  FutureOr<void> getcategories(
      GetCategoriesEvent event, Emitter<ProdcutsState> emit) async {
    final value = await getCategoriesUseCase.call();
    emit(LoadingProducts());
    value.fold((failure) {
      GetCategoriesFail(message: getfailure(failure: failure));
    }, (products) {
      categories = products;
      emit(GetCategoriesSuccess(products: products, message: 'message'));
    });
  }

  FutureOr<void> getcategory(
      GetCategoryEvent event, Emitter<ProdcutsState> emit) async {
    emit(LoadingProducts());
    final value = await categoryUseCase.call(id: event.id);
    value.fold((failure) {
      emit(GetCategoryFail(message: getfailure(failure: failure)));
    }, (products) {
      category_items = products;
      emit(GetCategorySuccess(
          title: event.title,
          products: products,
          message: getcategoriesSuccess));
    });
  }

  FutureOr<void> updatebannerindex(
      UpdateBannerIndextEvent event, Emitter<ProdcutsState> emit) {
    bannerindex = event.index;
    emit(UpdatedBannerIndexState(index: event.index));
  }

  FutureOr<void> getuserdata(
      GetUserDataEvent event, Emitter<ProdcutsState> emit) async {
    emit(LoadingProducts());
    final res = await userDataUsecase.call();
    res.fold((fail) {
      emit(GetUserDataFailState(message: getfailure(failure: fail)));
    }, (userEntiy) {
      userinfo = userEntiy;
      print(userinfo);
      emit(GetUserDataState(userEntiy: userinfo));
    });
  }

  FutureOr<void> updateproductindex(
      UpdateProductIndextEvent event, Emitter<ProdcutsState> emit) {
    productItemindex = event.index;
    emit(UpdatedBannerIndexState(index: event.index));
  }
}
