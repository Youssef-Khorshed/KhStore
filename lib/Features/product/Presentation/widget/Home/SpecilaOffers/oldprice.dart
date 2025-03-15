import 'package:flutter/material.dart';
import '../../../Logic/bloc/productBloc/prodcuts_bloc.dart';

Widget oldpriceText(
    {required int index,
    required ProdcutsBloc cal,
    required BuildContext context}) {
  return cal.some_offerproducts[index].discount > 0
      ? Positioned(
          bottom: 10,
          right: 38,
          child: Text(
            '${cal.some_offerproducts[index].oldPrice} EGP',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            // ignore: prefer_const_constructors
            style: TextStyle(
              color: Theme.of(context).textTheme.bodySmall!.color,
              fontSize: 15,
              decoration: TextDecoration.lineThrough,
            ),
          ))
      : Container();
}
