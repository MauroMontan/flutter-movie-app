import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return theme;
  }

  @override
  String get searchFieldLabel => "buscar pelicula";
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () => query = "",
          padding: const EdgeInsets.all(15),
          icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, 1), icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text("results");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const NoData();
    }
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);

    movieProvider.getSuggestionsByQuery(query);

    return StreamBuilder(
        stream: movieProvider.suggestionStream,
        builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
          if (!snapshot.hasData) {
            return const NoData();
          }

          final movies = snapshot.data;

          return ListView.builder(
            itemCount: movies?.length,
            itemBuilder: (context, index) {
              final movie = movies![index];
              return _MovieTile(movie: movie);
            },
          );
        });
  }
}

class _MovieTile extends StatelessWidget {
  final Movie movie;

  const _MovieTile({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    movie.setheroId = "search-${movie.id}";
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Hero(
          tag: movie.heroId,
          child: FadeInImage(
              placeholder: const AssetImage("assets/no-image.jpg"),
              image: NetworkImage(movie.fullPosterImg),
              width: 50,
              fit: BoxFit.contain),
        ),
        title: Text(movie.title),
        subtitle: Text(movie.releaseDate.toString()),
        onTap: () {
          Navigator.pushNamed(context, "details", arguments: movie);
        },
      ),
    );
  }
}

class NoData extends StatelessWidget {
  const NoData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: SvgPicture.asset(
        "assets/void.svg",
        height: 330,
        width: 330,
      ),
    ));
  }
}
