import 'package:flutter/material.dart';
import 'package:turnipoff/widgets/Poster.dart';

import '../models/MoviePreviewData.dart';

class PosterCarousel extends StatefulWidget {
  final Function(String) onMovieClicked;
  final List<Results> movies;

  const PosterCarousel(
      {Key? key, required this.onMovieClicked, required this.movies})
      : super(key: key);

  @override
  State<PosterCarousel> createState() => _PosterCarouselState();
}

class _PosterCarouselState extends State<PosterCarousel>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();

    _tabController =
        TabController(length: widget.movies.sublist(0, 7).length, vsync: this);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 3;

    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(children: [
        SizedBox(
            height: height,
            child: PageView(
                controller: _pageController,
                onPageChanged: (index) => _tabController.index = index,
                children: widget.movies
                    .sublist(0, 7)
                    .toList()
                    .map((movie) => Center(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.black,
                              elevation: 0,
                            ),
                            onPressed: () {
                              widget.onMovieClicked(movie.id.toString());
                            },
                            child: Poster(
                              url: movie.posterPath,
                              format: PosterFormat.w185,
                              height: height,
                            ))))
                    .toList())),
        Container(
            margin: const EdgeInsets.only(top: 16.0),
            child: TabPageSelector(
              controller: _tabController,
              //selectedColor: Colors.white,
              //color: Colors.transparent,
            ))
      ]),
    );
  }
}
