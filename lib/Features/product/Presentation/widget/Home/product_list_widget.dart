// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:store/Core/ReuseableComponent/navigation.dart';
import 'package:store/Core/ReuseableComponent/networkimage.dart';
import 'package:store/Core/colors.dart';
import 'package:store/Features/product/Domain/Entities/product/insidedata.dart';
import 'package:store/Features/product/Presentation/widget/Home/product.dart';

class PostListWidget extends StatelessWidget {
  final List<InsideData> items;
  final String title;
  const PostListWidget({
    Key? key,
    required this.items,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('$title'),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back))),
      body: grid(),
    );
  }

  Widget grid() {
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
              onTap: () => navigation(
                  context: context,
                  page: ProductPage(
                    product: items[index],
                  )),
              child: Stack(
                children: [
                  Hero(
                    tag: '${items[index].id}',
                    child: image(url: items[index].image!),
                  ),
                  Positioned(
                      bottom: 18,
                      child: Text(
                        'Price  ${items[index].price} EGP',
                        style: const TextStyle(color: color7, fontSize: 15),
                      )),
                  Positioned(
                      bottom: 45,
                      child: Text(
                        '${items[index].description}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          color: color7,
                          fontSize: 15,
                        ),
                      )),
                  discountText(
                      index: index,
                      discount: items[index].discount,
                      context: context),
                  oldpriceText(index: index, discount: items[index].discount),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget discountText(
      {required int index,
      required int discount,
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
                'Discount ${items[index].discount} EGP',
                style: const TextStyle(color: color3),
              ),
            ),
          )
        : Container();
  }

  Widget oldpriceText({required int index, required int discount}) {
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
                color: color_grey,
                fontSize: 15,
                decoration: TextDecoration.lineThrough,
              ),
            ))
        : Container();
  }
}
