import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:store/Features/cart/domain/entity/Carts.dart';
import 'package:store/Features/cart/domain/usecase/addcart.dart';
import 'package:store/Features/cart/domain/usecase/getcart.dart';
import 'package:store/Features/cart/domain/usecase/removecart.dart';
import '../../../../../Core/getFailure.dart';
import '../../../domain/entity/cartEntity.dart';
import '../../../domain/usecase/updatecart.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  AddToCartUsecase addToCartUsecase;
  RemoveFromCartUsecase removeFromCartUsecase;
  UpdateCartUsecase updateCartUsecase;
  GetCartUseCase getCartUseCase;
  List<CartItems> cartitems = [];
  Carts? carts;
  bool cart = false;
  // int quant = 1;
  CartBloc(
      {required this.getCartUseCase,
      required this.removeFromCartUsecase,
      required this.updateCartUsecase,
      required this.addToCartUsecase})
      : super(CartInitial()) {
    on<CartEvent>;
    on<AddToCartEvent>(addtocart);
    on<UpdateToCartEvent>(updatecart);
    on<RemoveFromCartEvent>(removeformcart);
    on<GetCartEvent>(getfromcart);
    // on<AddquantEvent>(addquant);
    // on<RemovequantEvent>(removequant);
  }

  FutureOr<void> getfromcart(
      GetCartEvent event, Emitter<CartState> emit) async {
    cartitems.clear();
    emit(LoadingCart());
    final value = await getCartUseCase.call();
    value.fold((l) {
      emit(GetCartFail(message: getfailure(failure: l)));
    }, (r) {
      cartitems = r.data!.cartItems!;
      carts = r;
      if (event.productid != null) {
        for (var element in cartitems) {
          if (element.product!.id == event.productid) {
            cart = true;
            break;
          } else {
            cart = false;
          }
        }
      }
      emit(GetCartSuccess(items: r));
    });
  }

  FutureOr<void> removeformcart(
      RemoveFromCartEvent event, Emitter<CartState> emit) async {
    final value =
        await removeFromCartUsecase.call(cartItemId: event.cartItemid);
    value.fold((l) {
      emit(GetCartFail(message: getfailure(failure: l)));
    }, (r) {
      emit(AddRemoveUpdateCartSuccess(message: r));
    });
  }

  FutureOr<void> updatecart(
      UpdateToCartEvent event, Emitter<CartState> emit) async {
    final value = await updateCartUsecase.call(
        cartItemId: event.productid, quantity: event.quantity);
    value.fold((l) {
      emit(GetCartFail(message: getfailure(failure: l)));
    }, (r) {
      emit(AddRemoveUpdateCartSuccess(message: r));
    });
  }

  FutureOr<void> addtocart(
      AddToCartEvent event, Emitter<CartState> emit) async {
    emit(LoadingCart());
    final value = await addToCartUsecase.call(
        productid: event.productid, quantity: event.quantity);
    value.fold((l) {
      emit(GetCartFail(message: getfailure(failure: l)));
    }, (r) {
      emit(AddRemoveUpdateCartSuccess(message: r));
      add(GetCartEvent(productid: event.productid));
    });
  }
}
