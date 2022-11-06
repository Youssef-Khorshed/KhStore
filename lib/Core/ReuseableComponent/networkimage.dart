import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget image(
    {required String url, double? width, double? height, BoxFit? fit}) {
  return CachedNetworkImage(
    imageUrl: url,
    width: width,
    height: height,
    fit: fit,
    placeholder: (context, url) =>
        const Center(child: CircularProgressIndicator()),
    errorWidget: (context, url, error) => const Icon(Icons.error),
  );
}
