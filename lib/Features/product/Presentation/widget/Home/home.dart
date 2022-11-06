// ignore_for_file: prefer_const_constructors

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/Core/ReuseableComponent/navigation.dart';
import 'package:store/Core/ReuseableComponent/networkimage.dart';
import 'package:store/Core/app.dart';
import 'package:store/Core/colors.dart';
import 'package:store/Core/strings.dart';
import 'package:store/Core/theme.dart';
import 'package:store/Features/auth/Presentation/Widgets/profile.dart';
import 'package:store/Features/product/Presentation/widget/Settings/settings.dart';
import 'package:store/Features/cart/presentation/logic/bloc/cart_bloc.dart';
import 'package:store/Features/cart/presentation/widgets/cart.dart';
import 'package:store/Features/favourite/presentation/logic/bloc/fav_bloc.dart';
import 'package:store/Features/favourite/presentation/widgets/favpage.dart';
import 'package:store/Features/product/Presentation/widget/Home/homepage/discount.dart';
import 'package:store/Features/product/Presentation/widget/Home/loading_widget.dart';
import 'package:store/Features/product/Presentation/widget/Home/product_list_widget.dart';
import '../../Logic/bloc/productBloc/prodcuts_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'homepage/carrosalpage.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final cartbloc = context.watch<CartBloc>();
    final favbloc = context.watch<FavBloc>();
    return BlocConsumer<ProdcutsBloc, ProdcutsState>(
      builder: (context, state) {
        final bloc = context.watch<ProdcutsBloc>();
        return bloc.userinfo == null || (state is LoadingProducts)
            ? LoadingWidget()
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
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        navigation(
                                            context: context, page: Profile());
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          elevation: 0.0),
                                      child: Row(
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          Icon(Icons.account_circle),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text('Profile')
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        favbloc.add(GetToFav(productid: null));
                                        navigation(
                                            context: context, page: FavPage());
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          elevation: 0.0),
                                      child: Row(
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          Icon(Icons.favorite),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text('Favourite')
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          cartbloc.add(
                                              GetCartEvent(productid: null));
                                          navigation(
                                              context: context,
                                              page: CartPage());
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.transparent,
                                            elevation: 0.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          // ignore: prefer_const_literals_to_create_immutables
                                          children: [
                                            Icon(Icons.shopping_cart),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text('Cart')
                                          ],
                                        )),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        navigation(
                                            context: context, page: Settings());
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          elevation: 0.0),
                                      child: Row(
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          Icon(Icons.settings),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text('Settings')
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                ThemeSwitcher.withTheme(
                                  builder: (_, switcher, theme) => TextButton(
                                      onPressed: () {
                                        switcher.changeTheme(
                                          theme: theme.brightness ==
                                                  Brightness.light
                                              ? ThemeClass.darkTheme
                                              : ThemeClass.lightTheme,
                                        );
                                      },
                                      child: Text('Theme')),
                                )
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
                            : SizedBox(
                                child: CarouselWithDotsPage(
                                imgList: bloc.banneritems,
                              )),
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
                        Container(
                          height: 200,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 10),
                            itemCount: bloc.some_offerproducts.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  ClipRRect(
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
                                  ),
                                  DiscountText(
                                      discount: bloc
                                          .some_offerproducts[index].discount),
                                  oldpriceText(index: index, cal: bloc),
                                ],
                              );
                            },
                            scrollDirection: Axis.horizontal,
                          ),
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

  Widget oldpriceText({required int index, required ProdcutsBloc cal}) {
    return cal.some_offerproducts[index].discount > 0
        ? Positioned(
            bottom: 2,
            right: 42,
            child: Text(
              '${cal.some_offerproducts[index].oldPrice} EGP',
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
