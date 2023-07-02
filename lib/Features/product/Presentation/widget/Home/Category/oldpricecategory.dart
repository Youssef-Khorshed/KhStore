import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../Core/colors.dart';
import '../../../../Domain/Entities/product/insidedata.dart';

Widget oldpriceText(
    {required int index,
    required int discount,
    required BuildContext context,
    required List<InsideData> items}) {
  return items[index].discount > 0
      ? Positioned(
          bottom: 2,
          right: 42,
          child: Text(
            '${items[index].oldPrice} EGP',
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
