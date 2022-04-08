import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movieapp/helpers/debouncer.dart';
import 'package:movieapp/models/cast.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/models/now_playing_response.dart';
import 'package:movieapp/models/popular_response.dart';
import 'package:movieapp/models/search_movie_response.dart';

class MovieProvider extends ChangeNotifier {
  final String _baseUrl = "api.themoviedb.org";
  final String _apiKey = "d7e6dcb5648d1a71941bc7cbd931ee78";
  final String _language = "es-MX";

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> movieCast = {};

  int _popularPage = 0;

  final debouncer = Debouncer(duration: const Duration(milliseconds: 500));

  final StreamController<List<Movie>> _suggestionsStreamController =
      StreamController.broadcast();

  Stream<List<Movie>> get suggestionStream =>
      _suggestionsStreamController.stream;

  MovieProvider() {
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String?> _getJsonData(String endpoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, endpoint,
        {"api_key": _apiKey, "language": _language, "page": "$page"});

    final response = await http.get(url);

    if (response.statusCode == 404) {
      return null;
    }

    return response.body;
  }

  void getOnDisplayMovies() async {
    final jsonData = await _getJsonData("3/movie/now_playing", 1);

    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData!);

    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;
    final jsonData = await _getJsonData('3/movie/popular', _popularPage);

    final popularResponse = PopularResponse.fromJson(jsonData!);

    popularMovies = [...popularMovies, ...popularResponse.results];

    notifyListeners();
  }

  Future<List<Cast>>? getCastMovie(int movieId) async {
    final jsonData = await _getJsonData("3/movie/$movieId/credits");

    final castResponse = CastResponse.fromJson(jsonData!);

    movieCast[movieId] = castResponse.cast;

    return castResponse.cast;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(_baseUrl, "3/search/movie",
        {"api_key": _apiKey, "language": _language, "query": query});

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);

    return searchResponse.results;
  }

  void getSuggestionsByQuery(String query) {
    debouncer.value = "";

    debouncer.onValue = (value) async {
      final results = await searchMovie(value);

      _suggestionsStreamController.add(results);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = query;
    });

    Future.delayed(const Duration(milliseconds: 301))
        .then((value) => timer.cancel());
  }
}
