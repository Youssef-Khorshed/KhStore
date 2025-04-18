import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/Core/AlertDialog.dart';
import 'package:store/Core/applocal.dart';
import 'package:store/Core/depndancyinjection.dart' as db;
import 'package:store/Core/strings.dart';
import 'package:store/Core/theme/theme_cubit.dart';
import 'package:store/Features/auth/Domain/Entity/userinfo.dart';
import '../Features/auth/Presentation/Logic/bloc/auth_bloc.dart';
import '../Features/cart/presentation/logic/bloc/cart_bloc.dart';
import '../Features/favourite/presentation/logic/bloc/fav_bloc.dart';
import '../Features/product/Presentation/Logic/bloc/productBloc/prodcuts_bloc.dart';
import 'ReuseableComponent/snackbar_message.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  Widget nextwidget;
  bool checkconnection;
  MyApp({super.key, required this.nextwidget, required this.checkconnection});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => db.db<AuthBloc>(),
          ),
          BlocProvider(
            create: (context) => db.db<CartBloc>(),
          ),
          BlocProvider(create: (context) => db.db<FavBloc>()),
          BlocProvider(create: (context) => db.db<ThemeCubit>()),
          BlocProvider(
              create: (_) => db.db<ProdcutsBloc>()
                ..add(GetBannerEvent())
                ..add(GetProdcutsEvent())
                ..add(GetCategoriesEvent())
                ..add(GetUserDataEvent())),
        ],
        child: BlocBuilder<ThemeCubit, bool>(builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            //   theme: ThemeMode.light,
            themeMode: state ? ThemeMode.light : ThemeMode.dark,
            darkTheme: ThemeCubit.darkTheme,
            home: checkconnection
                ? nextwidget
                : message(
                    message: 'Unable to connect to the internet.',
                    context: context),
            // ignore: prefer_const_literals_to_create_immutables
            localizationsDelegates: [
              AppLocale.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            // ignore: prefer_const_literals_to_create_immutables

            supportedLocales: const [
              Locale("en", ""), // English
              Locale("ar", ""), // arabic
            ],

            localeResolutionCallback: (currentLang, supportLang) {
              if (currentLang != null) {
                for (Locale locale in supportLang) {
                  if (locale.languageCode == currentLang.languageCode) {
                    currentLang.languageCode == "ar"
                        ? applang = "ar"
                        : applang = "en";

                    return currentLang;
                  }
                }
              }
              return supportLang.first;
            },
            // locale: Locale(applang, ''),
          );
        }));
  }
}

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    final fav = context.watch<FavBloc>();
    final auth = context.watch<AuthBloc>();
    // ignore: prefer_const_constructors
    return MultiBlocListener(
      listeners: [
        BlocListener<CartBloc, CartState>(
          listener: (context, state) {
            if (state is AddRemoveUpdateCartSuccess) {
              SnackBarMessage.showSuccessSnackBar(
                  message: state.message, context: context);
            }
          },
        ),
        BlocListener<FavBloc, FavState>(
          listener: (context, state) {
            if (state is GetFavSuccessState) {
              SnackBarMessage.showSuccessSnackBar(
                  message: fav.fav.toString(), context: context);
            }
          },
        ),
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Login_Success_State) {
              SnackBarMessage.showSuccessSnackBar(
                  message: state.entiy.data!.email!, context: context);
            } else if (state is LogoutSuccess) {
              SnackBarMessage.showSuccessSnackBar(
                  message: state.message, context: context);
            } else if (state is ForgetPasswordSuccess) {
              SnackBarMessage.showSuccessSnackBar(
                  message: state.message, context: context);
            } else if (state is Update_Success_State) {
              SnackBarMessage.showSuccessSnackBar(
                  message: state.entiy.data!.name!, context: context);
            } else if (state is AuthFailState) {
              SnackBarMessage.showSuccessSnackBar(
                  message: state.message, context: context);
            }
          },
        )
      ],
      child: Scaffold(
        // ignore: prefer_const_constructors
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                  onPressed: () {
                    auth.add(LoginEvent(
                        email: '11youssef@gmail.com', password: '1234567'));
                  },
                  child: const Text('Login')),
              TextButton(
                  onPressed: () {
                    auth.add(LogoutEvent());
                  },
                  child: const Text('Logout')),
              TextButton(
                  onPressed: () {
                    auth.add(ForgetPasswordEvent(password: '123456'));
                  },
                  child: const Text('ForgetPassword')),
              TextButton(
                  onPressed: () {
                    auth.add(UpdateEvent(
                        userEntiy: UserData(
                            email: '11youssef@gmail.com',
                            password: '',
                            name: 'youssef11',
                            phone: '0190000',
                            id: null,
                            image: null,
                            token: null)));
                  },
                  child: const Text('UpdateProfile'))
            ],
          ),
        ),
      ),
    );
  }
}

class RestartWidget extends StatefulWidget {
  const RestartWidget({super.key, required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
