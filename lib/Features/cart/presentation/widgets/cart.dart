import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/Core/ReuseableComponent/navigation.dart';
import 'package:store/Core/applocal.dart';
import 'package:store/Features/Payment/paymentUI.dart';
import 'package:store/Features/product/Presentation/widget/Home/loading_widget.dart';
import '../../../../Core/ReuseableComponent/networkimage.dart';
import '../../../../Core/colors.dart';
import '../logic/bloc/cart_bloc.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final bloc = context.watch<CartBloc>();
    return bloc.state is LoadingCart
        ? const LoadingWidget()
        : Scaffold(
            bottomNavigationBar: Container(
                margin: const EdgeInsets.all(20.0),
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    gradient:
                        const LinearGradient(colors: [color3, Colors.yellow]),
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Expanded(
                          child: Text(
                        textAlign: TextAlign.center,
                        '${getLang(context: context, key: "Total Price")} ${bloc.carts!.data!.total}  EGP',
                        style:
                            const TextStyle(fontSize: 25, color: Colors.white),
                      ))
                    ],
                  ),
                )),
            appBar: AppBar(
              elevation: 0,
              actions: [
                PaymentPage(
                  bloc: bloc,
                )
                // ElevatedButton(
                //     onPressed: () async {
                //       // await PaymentHelper.makepayment(
                //       //     price: bloc.carts!.data!.total.toString());
              ],
              backgroundColor: Colors.transparent,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
            ),
            body: grid(cal: bloc),
          );
  }

  Widget grid({required CartBloc cal}) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.7,
          crossAxisCount: 2,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2),
      itemCount: cal.carts!.data!.cartItems!.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Stack(
              children: [
                image(url: cal.carts!.data!.cartItems![index].product!.image!),
                Positioned(
                    bottom: 18,
                    child: Text(
                      'Price  ${cal.carts!.data!.cartItems![index].product!.price} EGP',
                      style: const TextStyle(color: color7, fontSize: 15),
                    )),
                Positioned(
                    bottom: 45,
                    child: Text(
                      '${cal.carts!.data!.cartItems![index].product!.description}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        color: color7,
                        fontSize: 15,
                      ),
                    )),
                discountText(
                    cal: cal,
                    index: index,
                    discount:
                        cal.carts!.data!.cartItems![index].product!.discount,
                    context: context),
                oldpriceText(
                  cal: cal,
                  index: index,
                ),
                Positioned(
                    bottom: 5,
                    right: -10,
                    child: IconButton(
                        onPressed: () {
                          cal.add(AddToCartEvent(
                              productid: cal
                                  .carts!.data!.cartItems![index].product!.id,
                              quantity: 0));
                        },
                        icon: const Icon(Icons.delete)))
              ],
            ),
          ),
        );
      },
    );
  }

  Widget discountText(
      {required int index,
      required int discount,
      required CartBloc cal,
      required BuildContext context}) {
    return discount > 0
        ? Positioned(
            top: 0,
            left: 0,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  color: color8, borderRadius: BorderRadius.circular(5)),
              child: Text(
                'Discount ${cal.carts!.data!.cartItems![index].product!.discount} EGP',
                style: const TextStyle(color: color3),
              ),
            ),
          )
        : Container();
  }

  Widget oldpriceText({required int index, required CartBloc cal}) {
    return cal.carts!.data!.cartItems![index].product!.discount > 0
        ? Positioned(
            bottom: 2,
            right: 42,
            child: Text(
              '${cal.carts!.data!.cartItems![index].product!.oldPrice} EGP',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              // ignore: prefer_const_constructors
              style: TextStyle(
                color: color_grey,
                fontSize: 15,
                decoration: TextDecoration.lineThrough,
              ),
            ))
        : Container();
  }
}
