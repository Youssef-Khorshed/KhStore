// ignore: non_constant_identifier_names
import 'package:flutter/cupertino.dart';

Image pageViewImage({required String img}) => Image(
      image: NetworkImage(img),
      fit: BoxFit.fill,
    );
