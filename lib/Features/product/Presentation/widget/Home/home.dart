// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:store/Core/ReuseableComponent/navigation.dart';
import 'package:store/Core/ReuseableComponent/networkimage.dart';
import 'package:store/Core/applocal.dart';
import 'package:store/Core/colors.dart';
import 'package:store/Core/strings.dart';
import 'package:store/Core/theme/theme_cubit.dart';
import 'package:store/Features/auth/Presentation/Logic/bloc/auth_bloc.dart';
import 'package:store/Features/auth/Presentation/Widgets/Auth/login.dart';
import 'package:store/Features/product/Presentation/widget/Home/Category/Categories.dart';
import 'package:store/Features/product/Presentation/widget/Home/SpecilaOffers/Specialoffers.dart';
import 'package:store/Features/product/Presentation/widget/Profile/profile.dart';
import 'package:store/Features/cart/presentation/logic/bloc/cart_bloc.dart';
import 'package:store/Features/cart/presentation/widgets/cart.dart';
import 'package:store/Features/favourite/presentation/logic/bloc/fav_bloc.dart';
import 'package:store/Features/favourite/presentation/widgets/favpage.dart';
import 'package:store/Features/product/Presentation/widget/Home/loading_widget.dart';
import 'package:store/Features/product/Presentation/widget/Home/Category/product_list_widget.dart';
import '../../../../../Core/ReuseableComponent/snackbar_message.dart';
import '../../Logic/bloc/productBloc/prodcuts_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'carrosalpage.dart';

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
    final theme = context.watch<ThemeCubit>();
    final authbloc = context.watch<AuthBloc>();

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
                          Text(
                            bloc.userinfo!.data!.name!,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            bloc.userinfo!.data!.phone!,
                          )
                          // ignore: prefer_const_literals_to_create_immutables
                          ,
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    if (await InternetConnectionChecker()
                                        .hasConnection) {
                                      // ignore: use_build_context_synchronously
                                      navigation(
                                          context: context, page: Profile());
                                    } else {
                                      // ignore: use_build_context_synchronously
                                      SnackBarMessage.showErrorSnackBar(
                                          message: 'No internet connection',
                                          context: context);
                                    }
                                  },
                                  style: Theme.of(context)
                                      .elevatedButtonTheme
                                      .style,
                                  child: Row(
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      Icon(Icons.account_circle,
                                          color: Theme.of(context)
                                              .iconTheme
                                              .color),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '${getLang(context: context, key: 'profile')}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    if (await InternetConnectionChecker()
                                        .hasConnection) {
                                      favbloc.add(GetToFav(productid: null));
                                      // ignore: use_build_context_synchronously
                                      navigation(
                                          context: context, page: FavPage());
                                    } else {
                                      // ignore: use_build_context_synchronously
                                      SnackBarMessage.showErrorSnackBar(
                                          message: 'No internet connection',
                                          context: context);
                                    }
                                  },
                                  style: Theme.of(context)
                                      .elevatedButtonTheme
                                      .style,
                                  child: Row(
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      Icon(Icons.favorite,
                                          color: Theme.of(context)
                                              .iconTheme
                                              .color),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        getLang(
                                            context: context,
                                            key: "Favourite")!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                ElevatedButton(
                                    onPressed: () async {
                                      if (await InternetConnectionChecker()
                                          .hasConnection) {
                                        cartbloc
                                            .add(GetCartEvent(productid: null));
                                        // ignore: use_build_context_synchronously
                                        navigation(
                                            context: context, page: CartPage());
                                      } else {
                                        // ignore: use_build_context_synchronously
                                        SnackBarMessage.showErrorSnackBar(
                                            // ignore: use_build_context_synchronously
                                            message: getLang(
                                                context: context,
                                                key: "No internet connection")!,
                                            context: context);
                                      }
                                    },
                                    style: Theme.of(context)
                                        .elevatedButtonTheme
                                        .style,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        Icon(Icons.shopping_cart,
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          getLang(
                                              context: context, key: "Cart")!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        )
                                      ],
                                    )),
                                SizedBox(
                                  height: 15,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    authbloc.add(LogoutEvent());
                                    navigation(
                                        context: context, page: LoginPage());
                                  },
                                  style: Theme.of(context)
                                      .elevatedButtonTheme
                                      .style,
                                  child: Row(
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      Icon(
                                        Icons.settings,
                                        color:
                                            Theme.of(context).iconTheme.color,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        getLang(
                                            context: context, key: "Logout")!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SwitchListTile(
                                  title: Row(
                                    children: [
                                      theme.state
                                          ? Icon(Icons.sunny)
                                          : Icon(Icons.nightlight),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(getLang(
                                          context: context, key: "App Mode")!),
                                    ],
                                  ),
                                  onChanged: (value) {
                                    theme.switch_theme(themestate: value);
                                  },
                                  value: theme.state,
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
                          getLang(context: context, key: "Category")!,
                          style: GoogleFonts.averageSans(
                              color: color2, fontSize: 20),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        HomeCategories(bloc: bloc),
                        Text(
                          getLang(context: context, key: "Special Offers")!,
                          style: GoogleFonts.averageSans(
                              color: color2, fontSize: 20),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        HomeOffers(bloc: bloc)
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
