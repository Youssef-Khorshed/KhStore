import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:store/Core/applocal.dart';
import 'package:store/Core/colors.dart';
import 'package:store/Features/auth/Presentation/Logic/bloc/auth_bloc.dart';
import 'package:store/Features/auth/Presentation/Widgets/Auth/component.dart';
import 'package:store/Features/product/Presentation/Logic/bloc/productBloc/prodcuts_bloc.dart';
import 'package:store/Features/product/Presentation/widget/Home/loading_widget.dart';

import '../../../../../Core/ReuseableComponent/snackbar_message.dart';
import '../../../../auth/Domain/Entity/userinfo.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final authbloc = context.watch<AuthBloc>();
    final productbloc = context.watch<ProdcutsBloc>();
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is ForgetPasswordSuccess) {
              print('successs');
              SnackBarMessage.showSuccessSnackBar(
                  message: state.message, context: context);
            } else if (state is Update_Success_State) {
              // SnackBarMessage.showSuccessSnackBar(
              //     message: state.entiy.data!.name!, context: context);
            } else if (state is AuthFailState) {
              SnackBarMessage.showSuccessSnackBar(
                  message: state.message, context: context);
            }
          },
        )
      ],
      child: authbloc.state is LoadingAuth ||
              productbloc.state is LoadingProducts
          ? const LoadingWidget()
          : Scaffold(
              bottomNavigationBar: Container(
                  margin: const EdgeInsets.all(20.0),
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                      // ignore: prefer_const_constructors
                      gradient: LinearGradient(colors: const [color1, color10]),
                      borderRadius: BorderRadius.circular(20)),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (await InternetConnectionChecker().hasConnection) {
                        authbloc.add(UpdateEvent(
                            userEntiy: UserData(
                                email: authbloc.signup_email.text.isEmpty
                                    ? productbloc.userinfo!.data!.email!
                                    : authbloc.signup_email.text,
                                password: '',
                                name: authbloc.signup_username.text.isEmpty
                                    ? productbloc.userinfo!.data!.name!
                                    : authbloc.signup_username.text,
                                phone: authbloc.signup_phone.text.isEmpty
                                    ? productbloc.userinfo!.data!.phone!
                                    : authbloc.signup_phone.text,
                                id: null,
                                image: null,
                                token: null)));
                        if (authbloc.signup_password.text.isEmpty != true) {
                          authbloc.add(ForgetPasswordEvent(
                              password: authbloc.signup_password.text));
                        }
                        productbloc.add(GetUserDataEvent());

                        authbloc.cleartext();
                      } else {
                        // ignore: use_build_context_synchronously
                        SnackBarMessage.showErrorSnackBar(
                            // ignore: use_build_context_synchronously
                            message: getLang(
                                context: context,
                                key: "No internet connection")!,
                            context: context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 0.0, backgroundColor: Colors.transparent),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Expanded(
                            flex: 1,
                            child: Icon(Icons.person, color: Colors.white)),
                        // ignore: prefer_const_constructors
                        Expanded(
                            flex: 3,
                            // ignore: prefer_const_constructors
                            child: Text(
                              textAlign: TextAlign.center,
                              getLang(context: context, key: "Edit profile")!,
                              style: const TextStyle(
                                  fontSize: 25, color: Colors.white),
                            ))
                      ],
                    ),
                  )),
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: const Text('Profile'),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(children: [
                    entryField(getLang(context: context, key: "Email")!,
                        controller: authbloc.signup_email,
                        isvalid: false,
                        hint: productbloc.userinfo!.data!.email!),
                    entryField(getLang(context: context, key: "Username")!,
                        controller: authbloc.signup_username,
                        isvalid: false,
                        hint: productbloc.userinfo!.data!.name!),
                    entryField(getLang(context: context, key: "Password")!,
                        controller: authbloc.signup_password,
                        hint: 'new password',
                        isPassword: true,
                        isvalid: false),
                    entryField(getLang(context: context, key: "Phone")!,
                        controller: authbloc.signup_phone,
                        isvalid: false,
                        hint: productbloc.userinfo!.data!.phone!)
                  ]),
                ),
              ),
            ),
    );
  }
}
