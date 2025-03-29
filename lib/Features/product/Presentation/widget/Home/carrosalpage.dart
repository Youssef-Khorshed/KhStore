import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:store/Core/ReuseableComponent/networkimage.dart';
import 'package:store/Features/product/Domain/Entities/banner/banner.dart';

// ignore: must_be_immutable
class CarouselWithDotsPage extends StatefulWidget {
  List<BannerData> imgList = [];

  CarouselWithDotsPage({super.key, required this.imgList});

  @override
  // ignore: library_private_types_in_public_api
  _CarouselWithDotsPageState createState() => _CarouselWithDotsPageState();
}

class _CarouselWithDotsPageState extends State<CarouselWithDotsPage> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = widget.imgList
        .map((item) => ClipRRect(
              // ignore: prefer_const_constructors
              borderRadius: BorderRadius.all(
                const Radius.circular(5.0),
              ),
              child: Stack(
                children: [
                  image(
                    url: item.image!,
                    fit: BoxFit.cover,
                    width: 1000,
                  ),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      // ignore: prefer_const_constructors
                      decoration: BoxDecoration(
                        // ignore: prefer_const_constructors
                        gradient: LinearGradient(
                          // ignore: prefer_const_literals_to_create_immutables
                          colors: [
                            const Color.fromARGB(200, 0, 0, 0),
                            const Color.fromARGB(0, 0, 0, 0),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      // ignore: prefer_const_constructors
                    ),
                  ),
                ],
              ),
            ))
        .toList();

    return Column(
      children: [
        // ignore: prefer_const_constructors
        SizedBox(
          height: 20,
        ),
        CarouselSlider(
          items: imageSliders,
          options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.imgList.map((url) {
            int index = widget.imgList.indexOf(url);
            return Container(
              width: 8,
              height: 8,
              // ignore: prefer_const_constructors
              margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 3,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index
                    ? const Color.fromRGBO(0, 0, 0, 0.9)
                    : const Color.fromRGBO(0, 0, 0, 0.4),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
