// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';

Widget message(
        {required String message,
        required BuildContext context,
        VoidCallback? onPressed,
        bool cancel = false}) =>
    AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: onPressed ??
                      () {
                        exit(0);
                      },
                  child: const Text('OK')),
              // const SizedBox(
              //   width: 5,
              // ),
              // TextButton(
              //     onPressed: () {
              //       RestartWidget(
              //         child: MyApp(internet: false),
              //       );
              //     },
              //     child: const Text('Cancel')),
              cancel
                  ? TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'))
                  : Container()
            ],
          )
        ],
      ),
    );
