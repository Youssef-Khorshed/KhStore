import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/Core/ReuseableComponent/navigation.dart';
import 'package:store/Core/ReuseableComponent/networkimage.dart';
import 'package:store/Core/strings.dart';
import 'package:store/Features/auth/Presentation/Widgets/login.dart';

import '../../../../../Core/app.dart';
import '../../../../auth/Presentation/Logic/bloc/auth_bloc.dart';
import '../../Logic/bloc/productBloc/prodcuts_bloc.dart';

class Settings extends StatefulWidget {
  Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  DropdownMenuItem<String> menuitems(
      {required String lang, required String flag}) {
    return DropdownMenuItem<String>(
      value: lang,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            image(url: flag, width: 100, height: 100, fit: BoxFit.fill),
            // ignore: prefer_const_constructors
            SizedBox(
              width: 10,
            ),
            Text(lang),
            // ignore: prefer_const_constructors
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> items = [];
  @override
  void initState() {
    items.add(
      menuitems(lang: 'ar', flag: egyptflag),
    );
    items.add(menuitems(lang: 'en', flag: usflag));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authbloc = context.watch<AuthBloc>();
    final productbloc = context.watch<ProdcutsBloc>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Settings'),
      ),
      // ignore: prefer_const_literals_to_create_immutables
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/logo.png'),
                  DropdownButton<String>(
                    icon: const Icon(Icons.flag_circle_outlined),
                    elevation: 1,
                    items: items,
                    hint: const Text('Select Language'),
                    onChanged: (value) {
                      applang = value!;
                      RestartWidget.restartApp(context);
                    },
                  ),
                  // ignore: prefer_const_constructors
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        authbloc.add(LogoutEvent());
                        animated_navigation(
                            context: context, widget: LoginPage());
                      },
                      child: Text('Sign out'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
