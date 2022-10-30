// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:store/Core/colors.dart';
import 'package:store/Features/product/Domain/Entities/product/insidedata.dart';

class PostListWidget extends StatelessWidget {
  final List<InsideData> posts;
  const PostListWidget({
    Key? key,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return grid();
  }

  Widget grid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.7,
          crossAxisCount: 2,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2),
      itemCount: posts.length,
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
                posts[index].image == null
                    ? const Text('Image Not found')
                    : Image.network('${posts[index].image}',
                        width: double.infinity, height: 150),
                Positioned(
                    bottom: 18,
                    child: Text(
                      'Price  ${posts[index].price} EGP',
                      style: const TextStyle(color: color7, fontSize: 15),
                    )),
                Positioned(
                    bottom: 45,
                    child: Text(
                      '${posts[index].description}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        color: color7,
                        fontSize: 15,
                      ),
                    )),
                discountText(index: index, discount: posts[index].discount),
                oldpriceText(index: index, discount: posts[index].discount),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget discountText({required int index, required int discount}) {
    return discount > 0
        ? Positioned(
            top: 0,
            left: 0,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  color: color8, borderRadius: BorderRadius.circular(5)),
              child: Text(
                'Discount ${posts[index].discount} EGP',
                style: const TextStyle(color: color3),
              ),
            ),
          )
        : Container();
  }

  Widget oldpriceText({required int index, required int discount}) {
    return posts[index].discount > 0
        ? Positioned(
            bottom: 2,
            right: 42,
            child: Text(
              '${posts[index].oldPrice} EGP',
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
