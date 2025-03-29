import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store/Core/applocal.dart';

import '../../../../../../Core/colors.dart';

class DiscountText extends StatelessWidget {
  int discount;

  DiscountText({super.key, required this.discount});

  @override
  Widget build(BuildContext context) {
    return discount > 0
        ? Positioned(
            top: 0,
            left: 0,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  color: color8, borderRadius: BorderRadius.circular(5)),
              child: Text(
                '${getLang(context: context, key: "Discount")} $discount EGP',
                style: TextStyle(color: color_wthite, fontSize: 12),
              ),
            ),
          )
        : Container();
  }
}
