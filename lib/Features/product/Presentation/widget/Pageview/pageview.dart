import 'package:flutter/material.dart';
import 'package:store/Core/ReuseableComponent/navigation.dart';
import 'package:store/Core/strings.dart';
import '../../../../../Core/ReuseableComponent/pageviewimg.dart';
import '../Home/home.dart';

class PAgeView extends StatefulWidget {
  const PAgeView({Key? key}) : super(key: key);

  @override
  State<PAgeView> createState() => _PAgeViewState();
}

class _PAgeViewState extends State<PAgeView> {
  List<Image> images = [];
  CircleAvatar shape1 = const CircleAvatar(
    backgroundColor: Colors.amber,
    radius: 5,
  );
  CircleAvatar shape2 = const CircleAvatar(
    backgroundColor: Colors.grey,
    radius: 5,
  );
  int index = 0;
  void initState() {
    images = [
      pageViewImage(img: pageviewImg1),
      pageViewImage(img: pageviewImg2),
      pageViewImage(img: pageviewImg3)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      return ListView(
        children: [
          Stack(
            children: [
              Container(
                  width: double.infinity, //double.infinity,
                  height: constrains.maxHeight,
                  child: images[index]),
              Positioned(
                // ignore: sort_child_properties_last
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      if (index < 2)
                        index++;
                      else if (index == 2) {
                        animated_navigation(context: context, widget: Home());
                      }
                    });
                  },
                  // ignore: prefer_const_constructors
                  child: Text(
                    'Next',
                    style: TextStyle(color: Colors.amber),
                  ),
                ),
                bottom: 15,
                left: constrains.maxWidth / 1.3,
              ),
              Positioned(
                bottom: 15,
                left: 20,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      if (index > 0) index--;
                    });
                  },
                  child: Text(
                    'Previous',
                    style: TextStyle(color: Colors.amber),
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                left: constrains.maxWidth / 2.3,
                child: Wrap(
                  spacing: 5,
                  children: [
                    index == 0 ? shape1 : shape2,
                    index == 1 ? shape1 : shape2,
                    index == 2 ? shape1 : shape2,
                  ],
                ),
              )
            ],
          )
        ],
      );
    });
  }
}
