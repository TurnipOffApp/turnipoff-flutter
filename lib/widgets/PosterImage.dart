import 'package:flutter/cupertino.dart';
import 'package:turnipoff/constants/network_constants.dart';

class PosterImage extends StatelessWidget {
  final String? url;
  double width = 88;
  double height = 132;

  PosterImage({Key? key, required this.url, this.width = 88, this.height = 132})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return url != null
        ? FadeInImage.assetNetwork(
            height: height,
            width: width,
            placeholder: 'assets/images/img_loading.png',
            image: NetworkConstants.BASE_IMAGE_URL + (url!))
        : Image.asset(
            'assets/images/img_placeholder.jpeg',
            height: height,
            width: width,
            fit: BoxFit.fill,
          );
  }
}
