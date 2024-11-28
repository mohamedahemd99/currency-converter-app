import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageNetworkWidget extends StatelessWidget {
  final String imagePath;
  final double? width, height;

  const ImageNetworkWidget(
      {super.key, required this.imagePath, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: imagePath,
        width: width ?? 16,
        height: height ?? 12,
        fit: BoxFit.cover,
        errorWidget: (context, error, stackTrace) => Icon(
              Icons.info_outline,
              size: 16,
            ));
  }
}
