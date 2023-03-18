import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixflex/Athentification/Login.dart';
import 'package:fixflex/Componeents/animation/transitionAnimation.dart';
import 'package:fixflex/Models/TvShow.dart';
import 'package:fixflex/Models/movies.dart';
import 'package:fixflex/Screans/Movies/AllMovies.dart';
import 'package:fixflex/Screans/TvShow/AllTvshow.dart';
import 'package:fixflex/Screans/Movies/DetailsMovies.dart';
import 'package:fixflex/Screans/TvShow/DetailsTvShow.dart';
import 'package:fixflex/constant.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:cached_network_image/cached_network_image.dart';

class AnimatedCard extends StatefulWidget {
  final List<ItemImage> list;
  final String title;

  // ignore: use_key_in_widget_constructors
  const AnimatedCard({required this.list, required this.title});

  @override
  // ignore: library_private_types_in_public_api
  _AnimatedCardState createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard> {
  int indexCurrent = 0;
  CarouselController carouselController = CarouselController();
  Widget sliderImages(BuildContext context, List<Widget> list) {
    return StatefulBuilder(builder: (context, setState) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.title,
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
              if (widget.title != 'Best Tv Show')
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      client = null;
                      Navigator.pushReplacement(
                          context,
                          SizeTransition4(Login(
                            signIn: true,
                          )));
                    },
                    child: Icon(
                      Icons.logout,
                      color: secondColor,
                    ),
                  ),
                )
            ],
          ),
          CarouselSlider(
            items: list,
            carouselController: carouselController,
            options: CarouselOptions(
                autoPlay: true,
                // autoPlayCurve: Curves.fastOutSlowIn,
                scrollPhysics: const BouncingScrollPhysics(),
                height: MediaQuery.of(context).size.height / 2,
                enlargeCenterPage: false,
                viewportFraction: 0.7,
                aspectRatio: 2,
                // viewportFraction: 0.8,

                //  aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    indexCurrent = index;
                  });
                }),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          sliderImages(context, widget.list),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RawMaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                onPressed: () {
                  if (widget.title == 'Best Tv Show') {
                    Navigator.push(context, SizeTransition1(const AllTvShow()));
                  } else {
                    Navigator.push(context, SizeTransition1(const AllMovies()));
                  }
                },
                fillColor: secondColor,
                splashColor: Colors.white,
                child: const Text(
                  'Check More',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              10.w
            ],
          )
        ],
      ),
    );
  }
}

class ItemImage extends StatelessWidget {
  final ResultsMovie? movie;
  final ResultsTvShow? tvShow;
  const ItemImage({Key? key, this.movie, this.tvShow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (movie != null) {
          Navigator.of(context).push(SizeTransition1(
            DetailsMovies(
              movie: movie!,
            ),
          ));
        } else {
          Navigator.of(context).push(SizeTransition1(
            DetailsTvShow(
              tvShow: tvShow!,
            ),
          ));
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 0, left: 2, right: 2),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromARGB(162, 23, 23, 23),
                      spreadRadius: 3,
                      blurRadius: 10)
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(8.0),
                ),
                child: CachedNetworkImage(
                  imageUrl: movie == null
                      ? "https://image.tmdb.org/t/p/w500${tvShow!.backdropPath ?? tvShow!.posterPath}"
                      : "https://image.tmdb.org/t/p/w500${movie!.backdropPath ?? movie!.posterPath}",
                  // height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width * 0.6,

                  imageBuilder: (context, imageProvider) => Container(
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,

                        fit: BoxFit.fill,

                        // colorFilter:
                        //     ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                      ),
                    ),
                  ),
                  placeholder: (context, url) =>
                      (MediaQuery.of(context).size.height / 3).h,

                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              movie == null ? tvShow!.name! : movie!.title!,
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            10.h,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[600]),
                  child: Text(
                    movie == null
                        ? tvShow!.firstAirDate!.isEmpty
                            ? "2023"
                            : tvShow!.firstAirDate!.toString().substring(0, 4)
                        : movie!.releaseDate!.isEmpty
                            ? "2023"
                            : movie!.releaseDate!.toString().substring(0, 4),
                    style: const TextStyle(fontSize: 16, color: Colors.white),
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
                          size: 15,
                        ),
                        FittedBox(
                          child: Text(
                            movie == null
                                ? tvShow!.voteAverage!.toString()
                                : movie!.voteAverage!.toString(),
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
