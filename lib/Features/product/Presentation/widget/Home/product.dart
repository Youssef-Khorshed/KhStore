// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store/Core/ReuseableComponent/networkimage.dart';
import 'package:store/Core/applocal.dart';
import 'package:store/Features/cart/presentation/logic/bloc/cart_bloc.dart';
import 'package:store/Features/favourite/presentation/logic/bloc/fav_bloc.dart';
import 'package:store/Features/product/Domain/Entities/product/insidedata.dart';
import 'package:store/Features/product/Presentation/Logic/bloc/productBloc/prodcuts_bloc.dart';
import 'package:store/Features/product/Presentation/widget/Home/loading_widget.dart';
import '../../../../../Core/colors.dart';
import 'ExpandText.dart';

class ProductPage extends StatefulWidget {
  InsideData product;
  ProductPage({super.key, required this.product});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.width;
    final blocproduct = context.watch<ProdcutsBloc>();
    final blocfav = context.watch<FavBloc>();
    final bloccart = context.watch<CartBloc>();
    final bloccartstate = context.watch<CartBloc>().state;

    return MultiBlocListener(
        // ignore: prefer_const_literals_to_create_immutables
        listeners: [
          BlocListener<CartBloc, CartState>(
            listener: (context, state) {},
          ),
          BlocListener<ProdcutsBloc, ProdcutsState>(
            listener: (context, state) {},
          ),
          BlocListener<FavBloc, FavState>(
            listener: (context, state) {},
          )
        ],
        child: (bloccartstate is LoadingCart ||
                blocfav.state is FavLoadingState)
            ? LoadingWidget()
            : Scaffold(
                bottomNavigationBar: Container(
                    margin: const EdgeInsets.all(20.0),
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [color1, color10]),
                        borderRadius: BorderRadius.circular(20)),
                    child: ElevatedButton(
                      onPressed: () {
                        // print(bloccart.quant);
                        bloccart.add(AddToCartEvent(
                            productid: widget.product.id, quantity: 1));
                        Timer(Duration(seconds: 2), () {});
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0.0, backgroundColor: Colors.transparent),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Expanded(
                              flex: 1,
                              child: Icon(Icons.shopping_cart_outlined,
                                  color: Colors.white)),
                          Expanded(
                              flex: 3,
                              child: Text(
                                textAlign: TextAlign.center,
                                getLang(
                                    context: context,
                                    key: bloccart.cart
                                        ? 'In Cart'
                                        : 'Add to Cart')!,
                                style: TextStyle(
                                    fontSize: 25, color: color_wthite),
                              ))
                        ],
                      ),
                    )),

                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back)),
                  actions: [
                    IconButton(
                        onPressed: () {
                          blocfav.add(AddToFav(productid: widget.product.id));
                        },
                        icon: blocfav.fav!
                            ? Icon(
                                Icons.favorite_border,
                                color: Colors.red,
                              )
                            : Icon(Icons.favorite_border))
                  ],
                ),
                // ignore: prefer_const_literals_to_create_immutables
                body: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  physics: BouncingScrollPhysics(),
                  children: [
                    // ignore: prefer_const_literals_to_create_immutables
                    Hero(
                      tag: '${widget.product.id}',
                      child: CarouselSlider.builder(
                          itemCount: widget.product.images!.length,
                          itemBuilder: (context, index, realIndex) {
                            blocproduct
                                .add(UpdateProductIndextEvent(index: index));
                            return Container(
                              child: image(url: widget.product.images![index]),
                            );
                          },
                          options: CarouselOptions()),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: width / 2.5),
                      child: Container(
                        height: 20,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            // ignore: unrelated_type_equality_checks
                            return index == blocproduct.productItemindex
                                ? CircleAvatar(
                                    radius: 3,
                                    backgroundColor: color1,
                                  )
                                : CircleAvatar(
                                    radius: 3,
                                    backgroundColor: color_grey2,
                                  );
                          },
                          itemCount: widget.product.images!.length,
                          separatorBuilder: (context, index) => SizedBox(
                            width: 25,
                          ),
                        ),
                      ),
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.product.name!,
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text('Price',
                            style: GoogleFonts.abel(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text('  ${widget.product.price} EGP',
                            style: GoogleFonts.abel(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: color3)),
                        // Spacer(),
                        // Qantity()
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextExpand(
                      text: widget.product.description!,
                    )
                  ],
                ),
              ));
  }
}
