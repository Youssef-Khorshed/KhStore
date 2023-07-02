import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/Core/applocal.dart';

import '../../../../../Core/ReuseableComponent/navigation.dart';
import '../../../../../Core/strings.dart';
import '../Auth/login.dart';

class Pageview_component {
  static List<AssetImage> images = [
    AssetImage(
      'assets/p1.png',
    ),
    AssetImage(
      'assets/p2.png',
    ),
    AssetImage(
      'assets/p3.png',
    )
  ];

  static TextButton skip_btn({required BuildContext context}) {
    return TextButton(
        onPressed: () async {
          final pref = await SharedPreferences.getInstance();
          await pref.setBool(pageviewkey, false);
          animated_navigation(context: context, widget: LoginPage());
        },
        child: Text(
          getLang(context: context, key: "skip")!,
          style: TextStyle(color: Colors.amber),
        ));
  }
}
