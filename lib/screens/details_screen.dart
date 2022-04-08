import 'package:flutter/material.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/widgets/widgets.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)?.settings.arguments as Movie;

    return Scaffold(
        body: CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        _CustomAppBar(
          poster: movie.backdropImg,
          title: movie.title,
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          _PosterAndTitle(
            poster: movie.fullPosterImg,
            title: movie.title,
            average: movie.voteAverage.toString(),
            originalTitle: movie.originalTitle,
            movieId: movie.heroId,
          ),
          _Overview(overview: movie.overview),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: CastingCards(movieId: movie.id),
          ),
        ]))
      ],
    ));
  }
}

class _PosterAndTitle extends StatelessWidget {
  final String poster;
  final String title;
  final String average;
  final String originalTitle;
  final String movieId;

  const _PosterAndTitle({
    Key? key,
    required this.poster,
    required this.title,
    required this.average,
    required this.originalTitle,
    required this.movieId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Hero(
            tag: movieId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                  height: 150,
                  placeholder: const AssetImage("assets/no-image.jpg"),
                  image: NetworkImage(poster)),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: textTheme.headline5,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2),
                const SizedBox(
                  height: 4,
                ),
                Text(originalTitle,
                    style: textTheme.headline6,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2),
                Row(
                  children: [
                    const Icon(
                      Icons.star_outline,
                      size: 25,
                      color: Colors.yellow,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(average,
                        style:
                            const TextStyle(color: Colors.yellow, height: 1.5))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final String poster;
  final String title;
  const _CustomAppBar({Key? key, required this.poster, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: const Color.fromRGBO(34, 40, 58, 1),
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Container(
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            color: const Color.fromRGBO(34, 40, 58, 0.26),
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              title,
              textAlign: TextAlign.center,
            )),
        centerTitle: true,
        titlePadding: EdgeInsets.zero,
        background: FadeInImage(
            fit: BoxFit.cover,
            placeholder: const AssetImage("assets/loading.gif"),
            image: NetworkImage(poster)),
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final String overview;
  const _Overview({Key? key, required this.overview}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Text(
        overview,
        textAlign: TextAlign.justify,
      ),
    );
  }
}
