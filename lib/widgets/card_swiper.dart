import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:movieapp/models/movie.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;
  const CardSwiper({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (movies.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: SizedBox(
        width: double.infinity,
        height: size.height * 0.49,
        child: Swiper(
          itemCount: movies.length,
          viewportFraction: 0.71,
          scale: 0.75,
          itemBuilder: (_, index) {
            final movie = movies[index];

            movie.setheroId = "swiper-${movie.id}";

            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "details", arguments: movie);
              },
              child: Hero(
                tag: movie.heroId,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: FadeInImage(
                      fit: BoxFit.fill,
                      placeholder: const AssetImage("assets/no-image.jpg"),
                      image: NetworkImage(movie.fullPosterImg)),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
