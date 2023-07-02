// ignore_for_file: unrelated_type_equality_checks

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/Core/strings.dart';
import 'package:store/Features/Payment/payment.dart';
import 'package:store/Features/auth/Presentation/Widgets/Auth/login.dart';
import 'package:store/Features/product/Presentation/widget/Home/home.dart';
import 'package:store/Features/auth/Presentation/Widgets/Pageview/pageview.dart';
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
  await stripinit();
  await db.init();
}

Future<void> stripinit() async {
  Stripe.publishableKey =
      'pk_test_51NJJYAIrGzQo7HkgqWuFPYDyPYJ8ELEvdjLDlRXdQrE6Ddvk0yAHra9d56jzbN4a9Fq0bENucFTU8KWoqsj6ZrLv00nV87HKJK';
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';
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
