import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/Presentation/Logic/bloc/check_internet_bloc_bloc.dart';
import 'package:store/Presentation/Logic/bloc/prodcuts_bloc.dart';
import 'package:store/Presentation/widget/Pageview/pageview.dart';
import 'package:store/Core/depndancyinjection.dart' as db;

import 'ReuseableComponent/snackbar_message.dart';

class MyApp extends StatelessWidget {
  // private constructor
  const MyApp._();

  // private instance
  static MyApp? _app;
  factory MyApp() {
    return _app ?? const MyApp._();
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => db.db<ProdcutsBloc>()..add(GetProdcutsEvent())),
          BlocProvider(
            create: (context) => db.db<CheckInternetBlocBloc>()
              ..add(CheckInternetFirstTimeEvent()),
          )
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            primarySwatch: Colors.blue,
          ),
          home: const Check(),
        ));
  }
}

class Check extends StatelessWidget {
  const Check({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckInternetBlocBloc, CheckInternetBlocState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(),
        // ignore: prefer_const_constructors
        body: Center(
          child: const Text('Data'),
        ),
      ),
      listener: (context, state) {
        if (state is ConnectedState) {
          SnackBarMessage.showSuccessSnackBar(
              message: 'Connected', context: context);
        } else {
          SnackBarMessage().showErrorSnackBar(
              message: 'No Internet Connection', context: context);
        }
      },
    );
  }
}
