import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/Core/ReuseableComponent/navigation.dart';
import 'package:store/Core/colors.dart';
import 'package:store/Core/strings.dart';
import 'package:store/Features/auth/Presentation/Widgets/Auth/login.dart';

import 'component.dart';

class Pageviews extends StatefulWidget {
  Pageviews({super.key});

  @override
  State<Pageviews> createState() => _PageviewsState();
}

class _PageviewsState extends State<Pageviews> {
  late PageController _controller;
  int _currentindex = 0;
  @override
  void initState() {
    _controller = PageController(initialPage: 0, viewportFraction: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      // appBar: AppBar(

      //   title: Text(
      //     'Kh Store',
      //     style: GoogleFonts.lobster(color: color1),
      //   ),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   actions: [
      //     TextButton(
      //         onPressed: () async {
      //           final pref = await SharedPreferences.getInstance();
      //           await pref.setBool(pageviewkey, false);
      //           animated_navigation(context: context, widget: LoginPage());
      //         },
      //         child: Text('Skip'))
      //   ],
      // ),

      body: ListView(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          // ignore: prefer_const_constructors
          SizedBox(
            height: h,
            width: w,
            child: Stack(
              children: [
                PageView(
                  // ignore: sort_child_properties_last
                  children: Pageview_component.images.map((e) {
                    return Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(image: e, fit: BoxFit.cover)),
                    );
                  }).toList(),
                  controller: _controller,
                  //  reverse: true,
                  onPageChanged: (value) {
                    setState(() {
                      _currentindex = value;
                    });
                  },
                ),
                Positioned(
                  height: h * 1.7,
                  width: w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: Pageview_component.images.map((url) {
                      int index = Pageview_component.images.indexOf(url);
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
                          color: _currentindex == index
                              ? Color.fromARGB(227, 211, 234, 0)
                              : Color.fromARGB(102, 165, 165, 165),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Positioned(
                    width: w * 1.8,
                    child: Pageview_component.skip_btn(context: context))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
