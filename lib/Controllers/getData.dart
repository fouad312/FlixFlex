import 'dart:convert';

import 'package:fixflex/Models/movies.dart';
import 'package:fixflex/Models/video.dart';
import 'package:http/http.dart' as http;

class GetData {
  String apiAll = """
https://api.themoviedb.org/3/discover/movie?api_key=fa16b8fa948c31a6684db7e7198958a9&language=en-US&sort_by=vote_average.desc&include_adult=false&include_video=true&page=1&with_watch_monetization_types=flatrate
""";
  String appi =
      "https://api.themoviedb.org/3/discover/movie?&api_key=fa16b8fa948c31a6684db7e7198958a9";
  String url =
      "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc?&api_key=fa16b8fa948c31a6684db7e7198958a9";
  String api =
      "https://api.themoviedb.org/3/movie/55?api_key=fa16b8fa948c31a6684db7e7198958a9";

  Future<Movie> getAllData() async {
    final response = await http.get(Uri.parse(apiAll));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final movie = Movie.fromJson(jsonData);
      // Do whatever you want with the movie object
      // For example, you can print the first movie title like this:
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
      // Do whatever you want with the movie object
      // For example, you can print the first movie title like this:
      return viedo;
      // print(movie.results![0].title);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Movie> fetchMovies() async {
    final response = await http.get(Uri.parse(appi));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final gg = decodeDemandesq(response.body);
      print(gg);
      final movies = await jsonDecode(response.body);
      // print(movies);
      Movie result = Movie.fromJson(movies);
      print(result.results![0].backdropPath);
      return result;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/550?api_key=fa16b8fa948c31a6684db7e7198958a9'));

    if (response.statusCode == 200) {
      // print(jsonDecode(response.body));
      final responseJson = jsonDecode(response.body);
      final listDemandes = decodeDemandesq(response.body);
      print('object');

      print(listDemandes.length);
      return responseJson.map((movie) => Movie.fromJson(movie));
    } else {
      throw Exception('Failed to load data');
    }
  }

  List<Movie> decodeDemandesq(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Movie>((json) => Movie.fromJson(json)).toList();
  }
}

  // void getMovieData() async {
  //   var endpointUrl =
  //       'https://moviesdatabase.p.rapidapi.com/titles/x/titles-by-ids';
  //   var apiKey = '0904ec13bcmsh5b14fccf9d68dbfp1237c6jsna65aa904d0ab';
  //   var host = 'moviesdatabase.p.rapidapi.com';

  //   var idsList = 'tt0001702,tt0001856,tt0001856';
  //   var apiUrl = '$endpointUrl?idsList=$idsList';

  //   var response = await http.get(Uri.parse(apiUrl),
  //       headers: {'X-RapidAPI-Key': apiKey, 'X-RapidAPI-Host': host});

  //   if (response.statusCode == 200) {
  //     print(response.body);
  //     MovieData result = MovieData.fromJson(jsonDecode(response.body));
  //     print(result.results[0].primaryImage);
  //   } else {
  //     print('Request failed with status: ${response.statusCode}.');
  //   }
  // }
