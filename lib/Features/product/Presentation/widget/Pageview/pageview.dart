import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/Core/ReuseableComponent/navigation.dart';
import 'package:store/Core/colors.dart';
import 'package:store/Core/strings.dart';
import 'package:store/Features/auth/Presentation/Widgets/login.dart';

class Pageviews extends StatefulWidget {
  List<Widget> images = [
    Image.asset(
      'assets/p1.png',
      fit: BoxFit.fill,
    ),
    Image.asset('assets/p2.png', fit: BoxFit.fill),
    Image.asset(
      'assets/p3.png',
      fit: BoxFit.fill,
    )
  ];
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
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        title: Text(
          'Kh Store',
          style: GoogleFonts.lobster(color: color1),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
              onPressed: () async {
                final pref = await SharedPreferences.getInstance();
                await pref.setBool(pageviewkey, false);
                animated_navigation(context: context, widget: LoginPage());
              },
              child: Text('Skip'))
        ],
      ),
      body: ListView(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          // ignore: prefer_const_constructors
          SizedBox(
            height: h / 1.2,
            child: PageView(
              // ignore: sort_child_properties_last
              children: widget.images.map((e) {
                return Container(
                  child: e,
                );
              }).toList(),
              controller: _controller,
              reverse: true,
              onPageChanged: (value) {
                setState(() {
                  _currentindex = value;
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.images.map((url) {
              int index = widget.images.indexOf(url);
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
                      ? const Color.fromRGBO(0, 0, 0, 0.9)
                      : const Color.fromRGBO(0, 0, 0, 0.4),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
