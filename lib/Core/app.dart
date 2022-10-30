import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/Core/colors.dart';
import 'package:store/Core/depndancyinjection.dart' as db;
import 'package:store/Features/auth/Presentation/Widgets/Login/login.dart';
import '../Features/auth/Presentation/Logic/bloc/auth_bloc.dart';
import '../Features/product/Presentation/Logic/bloc/checkinternetblock/check_internet_bloc_bloc.dart';
import '../Features/product/Presentation/Logic/bloc/productBloc/prodcuts_bloc.dart';
import '../Features/product/Presentation/widget/Home/home.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => db.db<CheckInternetBlocBloc>()
              ..add(CheckInternetFirstTimeEvent()),
          ),
          BlocProvider(
            create: (context) => db.db<AuthBloc>(),
          ),
          BlocProvider(
              create: (_) => db.db<ProdcutsBloc>()
                ..add(GetBannerEvent())
                ..add(GetProdcutsEvent())
                ..add(GetCategoriesEvent())),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: color6,
          ),
          home: LoginPage(),
        ));
  }
}
