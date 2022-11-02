// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store/Core/ReuseableComponent/networkimage.dart';
import 'package:store/Features/product/Domain/Entities/product/insidedata.dart';
import 'package:store/Features/product/Presentation/Logic/bloc/productBloc/prodcuts_bloc.dart';

import '../../../../../Core/colors.dart';
import 'ExpandText.dart';

class ProductPage extends StatelessWidget {
  InsideData product;
  ProductPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.width;
    final bloc = context.watch<ProdcutsBloc>();
    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(20.0),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [color1, color10]),
            borderRadius: BorderRadius.circular(20)),
        child: InkWell(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Expanded(
                  flex: 1,
                  child:
                      Icon(Icons.shopping_cart_outlined, color: Colors.white)),
              Expanded(
                  flex: 3,
                  child: Text(
                    textAlign: TextAlign.center,
                    'Add to Cart',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border))
        ],
      ),
      // ignore: prefer_const_literals_to_create_immutables
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ignore: prefer_const_literals_to_create_immutables

              Hero(
                tag: '${product.id}',
                child: CarouselSlider.builder(
                    itemCount: product.images!.length,
                    itemBuilder: (context, index, realIndex) {
                      bloc.add(UpdateProductIndextEvent(index: index));
                      return Container(
                        child: image(url: product.images![index]),
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
                      return index == bloc.productItemindex
                          // ignore: prefer_const_constructors
                          ? CircleAvatar(
                              radius: 3,
                              backgroundColor: color1,
                            )
                          : CircleAvatar(
                              radius: 3,
                              backgroundColor: color_grey2,
                            );
                    },
                    itemCount: product.images!.length,
                    // ignore: prefer_const_constructors
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
                    product.name!,
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text('Price ',
                      style: GoogleFonts.abel(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('  ${product.price} EGP',
                      style: GoogleFonts.abel(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: color3)),
                ],
              ),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 10,
              ),
              TextExpand(
                text: product.description!,
              )
            ],
          ),
        ),
      ),
    );
  }
}
