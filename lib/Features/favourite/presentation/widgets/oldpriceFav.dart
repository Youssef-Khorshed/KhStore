import 'package:flutter/cupertino.dart';

import '../../../../Core/colors.dart';
import '../logic/bloc/fav_bloc.dart';

class OldpriceText extends StatelessWidget {
  int index;
  FavBloc cal;
  OldpriceText({super.key, required this.index, required this.cal});

  @override
  Widget build(BuildContext context) {
    return cal.favdata[index].product!.discount > 0
        ? Positioned(
            bottom: 2,
            right: 42,
            child: Text(
              '${cal.favdata[index].product!.oldPrice} EGP',
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
