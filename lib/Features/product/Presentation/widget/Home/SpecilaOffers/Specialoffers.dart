import 'package:flutter/material.dart';

import '../../../../../../Core/ReuseableComponent/networkimage.dart';
import '../../../Logic/bloc/productBloc/prodcuts_bloc.dart';
import 'discount.dart';
import 'oldprice.dart';

class HomeOffers extends StatelessWidget {
  ProdcutsBloc bloc;
  HomeOffers({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(width: 10),
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
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        image(
                            url: bloc.some_offerproducts[index].images!.last,
                            width: 100,
                            height: 100),
                        SizedBox(
                          width: 100,
                          child: Text(
                            bloc.some_offerproducts[index].name!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              DiscountText(discount: bloc.some_offerproducts[index].discount),
              oldpriceText(index: index, cal: bloc, context: context),
            ],
          );
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
