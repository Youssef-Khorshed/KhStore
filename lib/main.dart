import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Core/app.dart';
import 'Presentation/Logic/BlocObserver/observer.dart';
import 'Core/depndancyinjection.dart' as db;

void main() async {
  await intialization();
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

Future<void> intialization() async {
  WidgetsFlutterBinding.ensureInitialized();

  await db.init();
}
