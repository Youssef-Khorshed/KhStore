import 'package:flutter/material.dart';

import '../../../../../Core/colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: const Center(
            child: CircularProgressIndicator(
          color: color6,
        )));
  }
}
