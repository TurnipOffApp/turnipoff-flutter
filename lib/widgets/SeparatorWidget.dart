import 'package:flutter/material.dart';

class SeparatorWidget extends StatelessWidget {
  const SeparatorWidget({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.secondary;
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 1,
        child:
        DecoratedBox(decoration: BoxDecoration(color: color)),
    );
  }
}