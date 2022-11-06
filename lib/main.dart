import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/Core/strings.dart';
import 'package:store/Features/auth/Presentation/Widgets/login.dart';
import 'package:store/Features/product/Presentation/widget/Home/home.dart';
import 'package:store/Features/product/Presentation/widget/Pageview/pageview.dart';
import 'Core/app.dart';
import 'Core/depndancyinjection.dart' as db;
import 'Features/product/Presentation/Logic/BlocObserver/observer.dart';

void main() async {
  await intialization();
  Bloc.observer = MyBlocObserver();

  runApp(RestartWidget(
      child: MyApp(
    nextwidget: await check_next(),
  )));
}

Future<void> intialization() async {
  WidgetsFlutterBinding.ensureInitialized();
  await db.init();
}

Future<Widget> check_next() async {
  final pref = await SharedPreferences.getInstance();
  final usertk = pref.get(usertokenkey);
  final pass = pref.get(userpasswrordkey);
  final pageview = pref.get(pageviewkey);
  late Widget next;
  if (pageview == null) {
    return Pageviews();
  } else {
    if (usertk == null || usertk == '') {
      return LoginPage();
    } else {
      return Home();
    }
  }
}
