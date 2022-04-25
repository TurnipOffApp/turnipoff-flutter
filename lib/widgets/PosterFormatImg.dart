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
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/img_placeholder.jpeg',
                image: NetworkConstants.BASE_IMAGE_URL + (path!),
                height: 132,
                width: 88,
              ),
            ),
          )
        : Image.asset(
            'assets/images/img_placeholder.jpeg',
            height: 132,
            width: 88,
          );
  }
}
