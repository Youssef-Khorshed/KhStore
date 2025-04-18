// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/Core/ReuseableComponent/navigation.dart';
import 'package:store/Core/ReuseableComponent/networkimage.dart';
import 'package:store/Core/colors.dart';
import 'package:store/Features/favourite/presentation/logic/bloc/fav_bloc.dart';
import 'package:store/Features/product/Domain/Entities/product/insidedata.dart';
import 'package:store/Features/product/Presentation/Logic/bloc/productBloc/prodcuts_bloc.dart';
import 'package:store/Features/product/Presentation/widget/Home/loading_widget.dart';
import 'package:store/Features/product/Presentation/widget/Home/product.dart';

import '../../../../../cart/presentation/logic/bloc/cart_bloc.dart';
import 'discountCategory.dart';
import 'oldpricecategory.dart';

class PostListWidget extends StatelessWidget {
  final List<InsideData> items;
  final String title;
  const PostListWidget({
    super.key,
    required this.items,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final cal = BlocProvider.of<CartBloc>(context);
    final productbloc = BlocProvider.of<ProdcutsBloc>(context);
    final blocfav = BlocProvider.of<FavBloc>(context);

    // ignore: unrelated_type_equality_checks
    return productbloc.state is LoadingProducts
        ? const LoadingWidget()
        : Scaffold(
            appBar: AppBar(
                title: Text('$title'),
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back))),
            body: grid(cal: cal, blocfav: blocfav),
          );
  }

  Widget grid({required CartBloc cal, required FavBloc blocfav}) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.7,
          crossAxisCount: 2,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              onTap: () {
                cal.add(GetCartEvent(productid: items[index].id));
                blocfav.add(GetToFav(productid: items[index].id));
                navigation(
                    context: context,
                    page: ProductPage(
                      product: items[index],
                    ));
              },
              child: Stack(
                children: [
                  Hero(
                    tag: '${items[index].id}',
                    child: image(
                        url: items[index].image!,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover),
                  ),
                  Positioned(
                      bottom: 18,
                      child: Text(
                        'Price  ${items[index].price} EGP',
                      )),
                  Positioned(
                      bottom: 45,
                      child: Text(
                        '${items[index].description}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )),
                  discountText(
                      index: index,
                      discount: items[index].discount,
                      items: items,
                      context: context),
                  oldpriceText(
                      context: context,
                      index: index,
                      discount: items[index].discount,
                      items: items),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
