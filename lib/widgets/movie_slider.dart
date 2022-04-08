import 'package:flutter/material.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/widgets/widgets.dart';

class MovieSlider extends StatefulWidget {
  final String? sectionTitle;
  final List<Movie> movies;

  final Function onNextPage;
  const MovieSlider({
    Key? key,
    this.sectionTitle,
    required this.movies,
    required this.onNextPage,
  }) : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 400) {
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 295,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              top: 10,
            ),
            child: Text(
              widget.sectionTitle ?? "",
              style: const TextStyle(color: Colors.amber, fontSize: 23),
            ),
          ),
          Expanded(
            child: ListView.builder(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: widget.movies.length,
                itemBuilder: (_, int index) {
                  final movie = widget.movies[index];

                  return MoviePoster(
                    movie: movie,
                    title: movie.title,
                    image: movie.fullPosterImg,
                  );
                }),
          ),
        ],
      ),
    );
  }
}
