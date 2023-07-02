// ignore_for_file: prefer_const_constructors

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:store/Core/colors.dart';
import 'package:store/Features/auth/Presentation/Logic/bloc/auth_bloc.dart';
import '../../../../../Core/ReuseableComponent/snackbar_message.dart';
import '../../../../../Core/applocal.dart';
import '../../../../product/Presentation/Logic/bloc/checkinternetblock/check_internet_bloc_bloc.dart';
import '../../../Domain/Entity/userinfo.dart';
import 'signup.dart';

Widget entryField(String title,
    {bool isPassword = false,
    bool isvalid = true,
    required TextEditingController controller,
    String? hint}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(
          height: 10,
        ),
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.text,
              validator: isvalid ? validation() : null,
              obscureText: isPassword,
              decoration: InputDecoration(
                  hintText: hint,
                  border: InputBorder.none,
                  fillColor: Colors.grey.shade300,
                  filled: true)),
        )
      ],
    ),
  );
}

String? Function(String?)? validation() {
  return (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
  };
}

Widget divider() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Row(
      // ignore: prefer_const_literals_to_create_immutables
      children: <Widget>[
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 1,
            ),
          ),
        ),
        Text('or'),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 1,
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    ),
  );
}

Widget submitButton({
  required AuthBloc bloc,
  required String email,
  required String password,
  required BuildContext context,
  required GlobalKey<FormState> formKey,
}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.symmetric(vertical: 15),
    alignment: Alignment.center,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.shade200,
              offset: Offset(2, 4),
              blurRadius: 5,
              spreadRadius: 2)
        ],
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: const [color3, Colors.yellow])),
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0, backgroundColor: Colors.transparent),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            if (await InternetConnectionChecker().hasConnection) {
              bloc.add(LoginEvent(email: email, password: password));
            } else {
              // ignore: use_build_context_synchronously
              SnackBarMessage.showErrorSnackBar(
                  message:
                      // ignore: use_build_context_synchronously
                      getLang(context: context, key: "No internet connection")!,
                  context: context);
            }
          }
        },
        child: Text(
          getLang(context: context, key: "Login")!,
          style: TextStyle(fontSize: 20, color: Colors.white),
        )),
  );
}

Widget createAccountLabel(
    {required BuildContext context,
    required String text,
    required Widget page}) {
  return InkWell(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => page));
    },
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(15),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Don\'t have an account ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: TextStyle(
                color: color3, fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
  );
}

Widget emailPasswordWidgetLogin(
    {required TextEditingController controllerEmail,
    controllerPassword,
    required BuildContext context}) {
  return Column(
    children: <Widget>[
      entryField(getLang(context: context, key: "Enter your Email")!,
          controller: controllerEmail),
      entryField(getLang(context: context, key: "Enter your Password")!,
          isPassword: true, controller: controllerPassword),
    ],
  );
}

Widget emailPasswordWidgetRegister(
    {required TextEditingController name,
    required TextEditingController email,
    required TextEditingController password,
    required TextEditingController phone,
    required BuildContext context}) {
  return Column(
    children: <Widget>[
      entryField(getLang(context: context, key: "Username")!, controller: name),
      entryField(getLang(context: context, key: "Email")!, controller: email),
      entryField(getLang(context: context, key: "Phone")!, controller: phone),
      entryField(getLang(context: context, key: "Password")!,
          isPassword: true, controller: password),
    ],
  );
}

Widget backButton({required BuildContext context}) {
  return InkWell(
    onTap: () {
      Navigator.pop(context);
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
            child: const Icon(Icons.keyboard_arrow_left, color: Colors.black),
          ),
          const Text('Back',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
        ],
      ),
    ),
  );
}

Widget submitButtonRegister(
    {required UserData userData,
    required AuthBloc bloc,
    required GlobalKey<FormState> formKey,
    required BuildContext context}) {
  return InkWell(
    onTap: () async {
      if (formKey.currentState!.validate()) {
        if (await InternetConnectionChecker().hasConnection) {
          bloc.add(RegisterEvent(userEntiy: userData));
        } else {
          // ignore: use_build_context_synchronously
          SnackBarMessage.showErrorSnackBar(
              // ignore: use_build_context_synchronously
              message:
                  // ignore: use_build_context_synchronously
                  getLang(context: context, key: "No internet connection")!,
              context: context);
        }
      }
    },
    child: Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: const Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          // ignore: prefer_const_constructors
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              // ignore: prefer_const_literals_to_create_immutables
              colors: [color3, Colors.yellow])),
      // ignore: prefer_const_constructors
      child: Text(
        getLang(context: context, key: "Register")!,
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
    ),
  );
}
