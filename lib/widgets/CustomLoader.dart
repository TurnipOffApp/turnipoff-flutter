import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  final Color color;
  final double size;
  const CustomLoader({Key? key, required this.color, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          color: color,
        ),
      ),
    );
  }
}
