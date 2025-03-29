import 'package:flutter/cupertino.dart';
import 'package:store/Core/applocal.dart';

import '../../../../Core/colors.dart';
import '../logic/bloc/fav_bloc.dart';

class DiscountFav extends StatelessWidget {
  int index;
  int discount;
  FavBloc cal;
  BuildContext context;
  DiscountFav({
    super.key,
    required this.index,
    required this.context,
    required this.discount,
    required this.cal,
  });

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
                '${getLang(context: context, key: "Discount")} ${cal.favdata[index].product!.discount} EGP',
                style: const TextStyle(color: color3),
              ),
            ),
          )
        : Container();
  }
}
