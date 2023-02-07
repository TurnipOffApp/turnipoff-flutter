import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turnipoff/constants/network_constants.dart';

class Poster extends StatelessWidget {
  final ratio = 2 / 3;

  final String? url;
  final double height;
  final PosterFormat format;

  const Poster(
      {Key? key, required this.url, required this.format, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    double width = height * ratio;

    return ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: url != null
            ? FadeInImage.assetNetwork(
                placeholder: 'assets/images/img_placeholder.jpeg',
                image: "${NetworkConstants.BASE_IMAGE_URL}/${format.name}/$url",
                height: height,
                width: width,
                placeholderCacheHeight: height.toInt(),
                placeholderCacheWidth: width.toInt(),
                fit: BoxFit.cover,
                fadeOutDuration: const Duration(milliseconds: 100),
                fadeInDuration: const Duration(milliseconds: 100))
            : Image.asset(
                'assets/images/img_placeholder.jpeg',
                height: height,
                width: width,
                fit: BoxFit.fill,
              ));
  }
}

enum PosterFormat { w92, w154, w185, w342, w500, w780, original }
