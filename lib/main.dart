import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'Core/app.dart';
import 'Core/depndancyinjection.dart' as db;
import 'Features/product/Presentation/Logic/BlocObserver/observer.dart';

void main() async {
  await intialization();
  // Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

Future<void> intialization() async {
  WidgetsFlutterBinding.ensureInitialized();

  await db.init();
}
