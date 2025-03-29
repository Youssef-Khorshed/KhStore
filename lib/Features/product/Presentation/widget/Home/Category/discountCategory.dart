import 'package:flutter/cupertino.dart';

import '../../../../../../Core/applocal.dart';
import '../../../../../../Core/colors.dart';
import '../../../../Domain/Entities/product/insidedata.dart';

Widget discountText(
    {required int index,
    required int discount,
    required List<InsideData> items,
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
              '${getLang(context: context, key: "Discount")} ${items[index].discount} EGP',
              style: TextStyle(color: color_wthite, fontSize: 12),
            ),
          ),
        )
      : Container();
}
