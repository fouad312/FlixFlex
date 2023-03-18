import 'dart:convert';

import 'package:fixflex/Models/TvShow.dart';
import 'package:fixflex/Models/movies.dart';
import 'package:fixflex/Models/video.dart';
import 'package:fixflex/constant.dart';
import 'package:http/http.dart' as http;

class GetData {
  Future<List<ResultsTvShow>> searchTvshow(String query) async {
    // requet for movie order by vote_average desc

    String api =
        """https://api.themoviedb.org/3/search/tv?api_key=fa16b8fa948c31a6684db7e7198958a9&language=en-US&page=1&query=$query&include_adult=false""";

    final response = await http.get(Uri.parse(api));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final movie = TvShow.fromJson(jsonData);
      searchTvShow.clear();
      searchTvShow = movie.results!;
    } else {
      throw Exception('Failed to load data');
    }

    return searchTvShow;
  }

  Future<List<ResultsMovie>> searchMovie(String query) async {
    // requet for movie order by vote_average desc

    String apiAll = """
https://api.themoviedb.org/3/search/movie?api_key=fa16b8fa948c31a6684db7e7198958a9&language=en-US&query=$query&page=1&include_adult=false
""";
    final response = await http.get(Uri.parse(apiAll));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final movie = Movie.fromJson(jsonData);
      searchMovies.clear();
      searchMovies = movie.results!;

      // Do whatever you want with the movie object
      // For example, you can print the first movie title like this:

      // print(movie.results![0].title);
    } else {
      throw Exception('Failed to load data');
    }

    return searchMovies;
  }

  Future<Movie> getPageIndex(String page) async {
    // requet for movie order by vote_average desc
    String apiAll = """
https://api.themoviedb.org/3/discover/movie?api_key=fa16b8fa948c31a6684db7e7198958a9&language=en-US&sort_by=vote_average.desc&include_adult=false&include_video=true&page=$page&with_watch_monetization_types=flatrate
""";
    final response = await http.get(Uri.parse(apiAll));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final movie = Movie.fromJson(jsonData);
      return movie;
      // print(movie.results![0].title);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<video> getVedio(String? idVedio) async {
    String apiVedio =
        """https://api.themoviedb.org/3/movie/${idVedio!}/videos?api_key=fa16b8fa948c31a6684db7e7198958a9&language=en-US""";
    final response = await http.get(Uri.parse(apiVedio));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      print("jsonData");

      print(jsonData);
      final viedo = video.fromJson(jsonData);
      return viedo;
      // print(movie.results![0].title);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<TvShow> getTvShowPage(String page) async {
    // requet for tvshow order by vote_average desc
    String tvShow =
        """https://api.themoviedb.org/3/discover/tv?api_key=fa16b8fa948c31a6684db7e7198958a9&language=en-US&sort_by=vote_average.desc&page=$page&timezone=America%2FNew_York&include_null_first_air_dates=false&with_watch_monetization_types=flatrate&with_status=0&with_type=0""";

    final response = await http.get(Uri.parse(tvShow));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print(jsonData);

      final tvShow = TvShow.fromJson(jsonData);
      return tvShow;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
