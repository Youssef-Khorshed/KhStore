// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/Core/ReuseableComponent/navigation.dart';
import 'package:store/Core/ReuseableComponent/networkimage.dart';
import 'package:store/Core/colors.dart';
import 'package:store/Features/product/Presentation/widget/Home/product_list_widget.dart';
import 'package:store/Features/product/Presentation/widget/categoryitems.dart';
import '../../Logic/bloc/productBloc/prodcuts_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProdcutsBloc, ProdcutsState>(
      builder: (context, state) {
        final bloc = context.watch<ProdcutsBloc>();
        return bloc.userinfo == null
            ? Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                body: Center(child: CircularProgressIndicator()),
              )
            : Scaffold(
                appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    title: Text(
                      'Kh Store',
                      style: GoogleFonts.lobster(color: color1),
                    ),
                    // ignore: prefer_const_literals_to_create_immutables
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadiusDirectional.circular(8),
                          child: image(
                              url: bloc.userinfo!.data!.image!,
                              width: 30,
                              height: 30),
                        ),
                      )
                    ],
                    elevation: 0,
                    leading: Builder(
                        builder: ((context) => IconButton(
                              onPressed: () =>
                                  Scaffold.of(context).openDrawer(),
                              icon: Icon(Icons.list),
                            )))),
                drawer: Drawer(
                  child: ListView(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      DrawerHeader(
                        child: image(url: bloc.userinfo!.data!.image!),
                      ),
                      Column(
                        children: [
                          Text(bloc.userinfo!.data!.name!),
                          SizedBox(
                            height: 10,
                          ),
                          Text(bloc.userinfo!.data!.phone!)
                          // ignore: prefer_const_literals_to_create_immutables
                          ,
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Row(
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Icon(Icons.account_circle),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Profile')
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Icon(Icons.favorite),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text('Favourite')
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Icon(Icons.shopping_cart),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text('Cart')
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Icon(Icons.settings),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text('Settings')
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        bloc.banneritems.isEmpty
                            ? Container(
                                padding: EdgeInsets.symmetric(horizontal: 30),
                                height: 150,
                                color: color_grey,
                              )
                            : Container(
                                height: 200,
                                child: CarouselSlider.builder(
                                    itemCount: bloc.banneritems.length,
                                    itemBuilder: (context, index, realIndex) {
                                      bloc.add(UpdateBannerIndextEvent(
                                          index: index));
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: image(
                                              url: bloc
                                                  .banneritems[index].image!),
                                        ),
                                      );
                                    },
                                    options: CarouselOptions(autoPlay: true)),
                              ),
                        Container(
                          padding: EdgeInsets.only(left: 70),
                          height: 20,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return index == bloc.bannerindex
                                  ? CircleAvatar(
                                      radius: 3,
                                      backgroundColor: color1,
                                    )
                                  : CircleAvatar(
                                      radius: 3,
                                      backgroundColor: color_grey2,
                                    );
                            },
                            itemCount: bloc.banneritems.length,
                            separatorBuilder: (context, index) => SizedBox(
                              width: 25,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Categories',
                          style: GoogleFonts.averageSans(
                              color: color2, fontSize: 20),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 150,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 10),
                            itemCount: bloc.categories.length,
                            itemBuilder: (context, index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Card(
                                  elevation: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: InkWell(
                                      onTap: () {
                                        bloc.add(GetCategoryEvent(
                                            title: bloc.categories[index].name,
                                            id: bloc.categories[index].id));
                                      },
                                      child: Column(
                                        children: [
                                          image(
                                              url: bloc.categories[index].image,
                                              width: 100,
                                              height: 100),
                                          Text(bloc.categories[index].name)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                        Text(
                          'Special Offers',
                          style: GoogleFonts.averageSans(
                              color: color2, fontSize: 20),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Stack(
                          children: [
                            Container(
                              height: 200,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    SizedBox(width: 10),
                                itemCount: bloc.some_offerproducts.length,
                                itemBuilder: (context, index) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Card(
                                      elevation: 1,
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            image(
                                                url: bloc
                                                    .some_offerproducts[index]
                                                    .images!
                                                    .last,
                                                width: 100,
                                                height: 100),
                                            SizedBox(
                                              width: 100,
                                              child: Text(
                                                bloc.some_offerproducts[index]
                                                    .name!,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                            Positioned(
                                // ignore: sort_child_properties_last
                                child: Text(
                                  'view More',
                                  style: GoogleFonts.averageSans(
                                      color: color3, fontSize: 15),
                                ),
                                bottom: 20,
                                right: 10),
                          ],
                        ),
                      ],
                    ),
                  ),
                ));
      },
      listener: (context, state) {
        final bloc = context.read<ProdcutsBloc>();
        if (state is GetCategorySuccess) {
          navigation(
              context: context,
              page: PostListWidget(
                items: bloc.category_items,
                title: state.title,
              ));
        }
      },
    );
  }
}
