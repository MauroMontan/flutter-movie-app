import 'package:flutter/material.dart';
import 'package:movieapp/models/cast.dart';
import 'package:movieapp/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  final int movieId;
  const CastingCards({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MovieProvider>(context, listen: false);
    return FutureBuilder(
      future: moviesProvider.getCastMovie(movieId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            margin: const EdgeInsets.only(top: 60, bottom: 30),
            width: double.infinity,
            height: 50,
            child: const Center(
                child: CircularProgressIndicator(
              color: Colors.green,
            )),
          );
        }

        final List<Cast>? cast = snapshot.data;

        return SizedBox(
          width: double.infinity,
          height: 190,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: cast?.length,
              itemBuilder: (context, index) {
                final actor = cast![index];
                return CastCard(
                  actor: actor,
                );
              }),
        );
      },
    );
  }
}

class CastCard extends StatelessWidget {
  final Cast actor;
  const CastCard({Key? key, required this.actor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      width: 110,
      height: 100,
      child: Column(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                height: 145,
                width: 100,
                fit: BoxFit.cover,
                image: NetworkImage(actor.profileImg),
                imageErrorBuilder: (context, error, stackTrace) {
                  return const Image(
                    image: AssetImage("assets/no-image.jpg"),
                    height: 145,
                    width: 100,
                  );
                },
                placeholder: const AssetImage("assets/no-image.jpg"),
              )),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            maxLines: 2,
          )
        ],
      ),
    );
  }
}
