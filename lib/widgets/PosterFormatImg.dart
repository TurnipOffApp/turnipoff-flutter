import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/network_constants.dart';

class PosterFormatImg extends StatelessWidget {
  const PosterFormatImg({
    Key? key,
    required this.path,
  }) : super(key: key);

  final String? path;

  @override
  Widget build(BuildContext context) {
    return path != null
        ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                  height: 132,
                  width: 88,
                  fit: BoxFit.fitWidth,
                  placeholder: (context, url) =>
                      Image.asset('assets/images/img_placeholder.jpeg'),
                  imageUrl: NetworkConstants.BASE_IMAGE_URL + (path!),
                  fadeOutDuration: const Duration(seconds: 1),
                  fadeInDuration: const Duration(milliseconds: 200)),
            ),
          )
        : Image.asset(
            'assets/images/img_placeholder.jpeg',
            height: 132,
            width: 88,
          );
  }
}
