import 'package:flutter/material.dart';

import 'Poster.dart';

class GenericSection extends StatelessWidget {
  final String title;
  final Iterable<GenericSectionItem> items;
  final Function(GenericSectionItem) onItemClicked;

  const GenericSection(
      {Key? key,
      required this.title,
      required this.items,
      required this.onItemClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        const SizedBox(
          height: 12,
        ),
        Text(
          title,
          style: textTheme.labelLarge,
        ),
        SizedBox(
          height: 250,
          child: ListView.builder(
              itemCount: items.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return _getItem(context, items.elementAt(index));
              }),
        )
      ],
    );
  }

  Widget _getItem(BuildContext context, GenericSectionItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 12),
      child: GestureDetector(
          onTap: () {
            onItemClicked(item);
          },
          child: Column(
            children: [
              Poster(
                url: item.imagePath,
                format: PosterFormat.w185,
                height: MediaQuery.of(context).size.height / 5,
              ),
              Text(item.title ?? "",
                  textAlign: TextAlign.center, overflow: TextOverflow.ellipsis),
              Text(
                item.subTitle ?? "",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              )
            ],
          )),
    );
  }
}

class GenericSectionItem {
  int? id;
  String? imagePath;
  String? title;
  String? subTitle;

  GenericSectionItem({this.id, this.imagePath, this.title, this.subTitle});
}
