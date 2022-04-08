import 'package:flutter/material.dart';
import 'package:movieapp/models/movie.dart';

class MoviePoster extends StatelessWidget {
  final String image;
  final String? title;
  final Movie movie;

  const MoviePoster(
      {Key? key, this.title, required this.image, required this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    movie.setheroId = "poster-${movie.id}";

    return Container(
      width: 130,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "details", arguments: movie);
            },
            child: Hero(
              tag: movie.heroId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(23),
                child: FadeInImage(
                    height: 185,
                    width: 135,
                    fit: BoxFit.cover,
                    placeholder: const AssetImage("assets/no-image.jpg"),
                    image: NetworkImage(image)),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(title ?? "",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 2),
        ],
      ),
    );
  }
}
