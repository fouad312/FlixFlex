import 'package:fixflex/Models/TvShow.dart';
import 'package:fixflex/Models/movies.dart';

class GetBest {
  void getBestFive(List<ResultsMovie> list) {
    list.sort(
      (a, b) => b.voteAverage!.compareTo(a.voteAverage!),
    );
  }

  void getBestFiveTvShow(List<ResultsTvShow> list) {
    list.sort(
      (a, b) => b.voteAverage!.compareTo(a.voteAverage!),
    );
  }
}
