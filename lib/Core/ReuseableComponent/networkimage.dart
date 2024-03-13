import 'package:flutter/material.dart';
import 'package:store/Core/strings.dart';

Widget image(
    {required String? url, double? width, double? height, BoxFit? fit}) {
  return FadeInImage(
    width: width,
    height: height,
    image: NetworkImage(url ?? error_image),
    placeholder: AssetImage("assets/image.png"),
    imageErrorBuilder: (context, error, stackTrace) {
      return Image.asset('assets/erro.png', fit: fit);
    },
    fit: BoxFit.fitWidth,
  );
}
