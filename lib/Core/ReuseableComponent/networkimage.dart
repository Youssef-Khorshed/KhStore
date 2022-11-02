import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget image({required String url, double? width, double? height}) {
  return CachedNetworkImage(
    imageUrl: url,
    width: width,
    height: height,
    placeholder: (context, url) =>
        const Center(child: CircularProgressIndicator()),
    errorWidget: (context, url, error) => const Icon(Icons.error),
  );
}
