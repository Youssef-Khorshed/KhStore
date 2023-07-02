import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/Core/strings.dart';
import 'package:store/Features/auth/Domain/Entity/userinfo.dart';
import 'package:store/Features/auth/Presentation/Logic/bloc/auth_bloc.dart';
import '../../../../../Core/ReuseableComponent/snackbar_message.dart';
import '../../../../../Core/applocal.dart';
import 'component.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  // ignore: library_private_types_in_public_api
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocConsumer<AuthBloc, AuthState>(
      builder: (context, state) {
        final bloc = context.watch<AuthBloc>();
        return Scaffold(
          body: SizedBox(
            height: height,
            child: Stack(
              children: <Widget>[
                Positioned(
                  child: Image.asset(
                    'assets/Layer 1.png',
                    width: width / 3,
                    height: height / 3,
                    fit: BoxFit.fill,
                  ),
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
                          Image.asset(
                            'assets/logo.png',
                            width: width / 3,
                            height: height / 3,
                            fit: BoxFit.cover,
                          ),
                          emailPasswordWidgetRegister(
                              context: context,
                              name: bloc.signup_username,
                              phone: bloc.signup_phone,
                              email: bloc.signup_email,
                              password: bloc.signup_password),
                          const SizedBox(
                            height: 10,
                          ),
                          state is LoadingAuth
                              ? Text(getLang(
                                  context: context, key: "Please wait....")!)
                              : submitButtonRegister(
                                  bloc: bloc,
                                  userData: UserData(
                                      email: bloc.signup_email.text,
                                      password: bloc.signup_password.text,
                                      name: bloc.signup_username.text,
                                      phone: bloc.signup_phone.text,
                                      id: null,
                                      image: defaultimg,
                                      token: null),
                                  context: context,
                                  formKey: _formKey),
                          createAccountLabel(
                            context: context,
                            text: getLang(context: context, key: "Login")!,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 40, left: 0, child: backButton(context: context)),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is Registe_Success_State) {}
        if (state is AuthFailState) {}
      },
    );
  }
}
