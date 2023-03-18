import 'package:fixflex/Controllers/getData.dart';
import 'package:fixflex/Models/movies.dart';
import 'package:fixflex/Models/video.dart';
import 'package:fixflex/constant.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailsMovies extends StatelessWidget {
  final ResultsMovie movie;
  DetailsMovies({super.key, required this.movie});
  late YoutubePlayerController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Image.network(
                  "https://image.tmdb.org/t/p/w500${movie.backdropPath ?? movie.posterPath}",
                  height: MediaQuery.of(context).size.height / 2,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
                Positioned(left: 5, child: backbutton(context, secondColor))
              ],
            ),
            10.h,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                10.w,
                Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[600]),
                  child: Text(
                    movie.releaseDate!.toString().substring(0, 4),
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                20.w,
                Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[600]),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.star_outlined,
                          color: Colors.yellow,
                          size: 18,
                        ),
                        FittedBox(
                          child: Text(
                            movie.voteAverage!.toString(),
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movie.title!,
                style: const TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movie.overview!,
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            // if (movie.video == true)
            FutureBuilder<video>(
              future: GetData().getVedio(movie.id!.toString()),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: secondColor,
                    ),
                  );
                }
                if (snapshot.hasData) {
                  _controller = YoutubePlayerController(
                    initialVideoId: snapshot.data!.results!.isNotEmpty
                        ? snapshot.data!.results![0].key!
                        : '',
                  );
                  return snapshot.data!.results!.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Trailer Movie ',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Center(
                              child: YoutubePlayer(
                                controller: _controller,
                                showVideoProgressIndicator: true,
                              ),
                            ),
                            100.h
                          ],
                        )
                      // Text(
                      //                     "https://www.youtube.com/watch?v=${snapshot.data!.results![0].key}}",
                      //                     style: const TextStyle(color: Colors.white),
                      //                   )
                      : Container(
                          child: const Text(
                            "Ops there is No Trailer",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                        );
                } else {
                  return const Text(
                    'eror',
                    style: TextStyle(color: Colors.white),
                  );
                }
              },
            )
          ],
        ),
      )),
    );
  }
}
