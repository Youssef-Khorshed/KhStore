import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/Core/applocal.dart';
import 'package:store/Core/strings.dart';
import 'package:store/Features/cart/domain/entity/cartEntity.dart';
import 'package:store/Features/favourite/presentation/logic/bloc/fav_bloc.dart';
import 'package:store/Features/favourite/presentation/widgets/discounttext.dart';
import 'package:store/Features/product/Presentation/widget/Home/loading_widget.dart';
import '../../../../Core/ReuseableComponent/networkimage.dart';
import '../../../../Core/colors.dart';
import 'oldpriceFav.dart';

class FavPage extends StatelessWidget {
  FavPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final bloc = context.watch<FavBloc>();
    return bloc.state is FavLoadingState
        ? const LoadingWidget()
        : Scaffold(
            appBar: AppBar(
              title: Text(
                getLang(context: context, key: "Favourite")!,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
            ),
            body: bloc.favdata.length == 0
                ? Center(child: image(url: no_item_found))
                : grid(cal: bloc),
          );
  }

  Widget grid({required FavBloc cal}) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.7,
          crossAxisCount: 2,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2),
      itemCount: cal.favdata.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Stack(
              children: [
                image(url: cal.favdata[index].product!.image!),
                Positioned(
                    bottom: 18,
                    child: Text(
                      '${getLang(context: context, key: "Price")!}  ${cal.favdata[index].product!.price} EGP',
                      style: const TextStyle(color: color7, fontSize: 15),
                    )),
                Positioned(
                    bottom: 45,
                    child: Text(
                      '${cal.favdata[index].product!.description}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        color: color7,
                        fontSize: 15,
                      ),
                    )),
                DiscountFav(
                    cal: cal,
                    index: index,
                    discount: cal.favdata[index].product!.discount,
                    context: context),
                OldpriceText(
                  cal: cal,
                  index: index,
                ),
                Positioned(
                    bottom: 5,
                    right: -2,
                    child: IconButton(
                        onPressed: () {
                          cal.add(AddToFav(
                            productid: cal.favdata[index].product!.id,
                          ));
                        },
                        icon: const Icon(Icons.delete)))
              ],
            ),
          ),
        );
      },
    );
  }
}
