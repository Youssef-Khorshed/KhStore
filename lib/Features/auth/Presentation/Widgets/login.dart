// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/Core/ReuseableComponent/navigation.dart';
import 'package:store/Core/colors.dart';
import 'package:store/Features/auth/Presentation/Logic/bloc/auth_bloc.dart';
import 'package:store/Features/product/Presentation/Logic/bloc/productBloc/prodcuts_bloc.dart';
import 'package:store/Features/product/Presentation/widget/Home/home.dart';
import 'package:store/Features/product/Presentation/widget/Home/loading_widget.dart';
import '../../../../Core/ReuseableComponent/snackbar_message.dart';
import 'component.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final bloc = context.watch<AuthBloc>();
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Login_Success_State) {
          SnackBarMessage.showSuccessSnackBar(
              message: state.entiy.message!, context: context);
          animated_navigation(context: context, widget: Home());
        }
        if (state is AuthFailState) {
          SnackBarMessage.showErrorSnackBar(
              message: state.message, context: context);
        }
      },
      child: Scaffold(
          // ignore: unrelated_type_equality_checks
          body: Stack(
        children: [
          Image.asset(
            'assets/Layer 1.png',
            width: width / 3,
            height: height / 3,
            fit: BoxFit.fill,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: height / 20,
                    ),
                    Image.asset(
                      'assets/logo.png',
                      width: width / 3,
                      height: height / 3,
                      fit: BoxFit.cover,
                    ),
                    emailPasswordWidgetLogin(
                        controllerEmail: bloc.email_controller,
                        controllerPassword: bloc.password_controller),
                    const SizedBox(height: 20),
                    bloc.state is LoadingAuth
                        ? Text('Please wait....')
                        : submitButton(
                            formKey: _formKey,
                            bloc: bloc,
                            email: bloc.email_controller.text,
                            password: bloc.password_controller.text,
                            context: context),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.centerRight,
                      child: const Text('Forgot Password ?',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500)),
                    ),
                    divider(),
                    createAccountLabel(context: context, text: 'Register'),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
