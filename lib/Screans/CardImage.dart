import 'package:fixflex/Componeents/animation/transitionAnimation.dart';
import 'package:fixflex/Models/movies.dart';
import 'package:fixflex/Screans/DetailsMovies.dart';
import 'package:fixflex/constant.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'dart:ui' as ui;
import 'package:cached_network_image/cached_network_image.dart';

class AnimatedCard extends StatefulWidget {
  final List<ItemImage> list;

  // ignore: use_key_in_widget_constructors
  const AnimatedCard({required this.list});

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
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Best Movies",
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
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
          // SizedBox(
          //   height: 50,
          //   child: ListView.builder(
          //       scrollDirection: Axis.horizontal,
          //       shrinkWrap: true,
          //       physics: const BouncingScrollPhysics(),
          //       itemCount: list.length,
          //       itemBuilder: (context, index) {
          //         return Container(
          //           width: 10,
          //           height: 10,
          //           margin: const EdgeInsets.symmetric(
          //             vertical: 10,
          //             horizontal: 3,
          //           ),
          //           decoration: BoxDecoration(
          //             shape: BoxShape.circle,
          //             color: _current == index
          //                 ? primaryColor
          //                 : Colors.pinkAccent.withOpacity(0.2),
          //           ),
          //         );
          //         //   widget.imgList!.map((url) {
          //         //   int index = widget.imgList!.indexOf(url);
          //         //   return;
          //         // })
          //         // },

          //         //  children: ).toList(),
          //       }),
          // ),
          // arrowNavigate()
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: secondColor,
          child: const Icon(
            Icons.search_rounded,
            color: Colors.white,
          ),
        ),
        backgroundColor: primaryColor,
        body: SafeArea(
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  sliderImages(context, widget.list),
                ],
              )),
        ),
      ),
    );
  }

  // Row arrowNavigate() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Expanded(
  //           flex: 1,
  //           child: Align(
  //             alignment: Alignment.centerLeft,
  //             child: RawMaterialButton(
  //               shape: const CircleBorder(),
  //               splashColor: Colors.white,
  //               fillColor: primaryColor,
  //               //  shape: BoxShape.circle,
  //               onPressed: () {
  //                 carouselController.previousPage(
  //                     curve: Curves.easeInOut,
  //                     duration: const Duration(milliseconds: 1000));
  //               },
  //               child: const Padding(
  //                 padding: EdgeInsets.all(8.0),
  //                 child: Icon(
  //                   FontAwesomeIcons.angleLeft,
  //                   color: Colors.white,
  //                 ),
  //               ),
  //             ),
  //           )),
  //       Expanded(
  //           flex: 1,
  //           child: Align(
  //             alignment: Alignment.centerRight,
  //             child: RawMaterialButton(
  //               shape: const CircleBorder(),
  //               fillColor: primaryColor,
  //               onPressed: () {
  //                 carouselController.nextPage(
  //                     curve: Curves.easeInOut,
  //                     duration: const Duration(milliseconds: 1000));
  //                 //   setState(() {});
  //               },
  //               child: const Padding(
  //                 padding: EdgeInsets.all(8.0),
  //                 child: Icon(
  //                   FontAwesomeIcons.angleRight,
  //                   color: Colors.white,
  //                 ),
  //               ),
  //             ),
  //           )),
  //     ],
  //   );
  // }
}

class ItemImage extends StatelessWidget {
  final ResultsMovie movie;
  const ItemImage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(SizeTransition1(
          DetailsMovies(
            movie: movie,
          ),
        ));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 8, left: 2, right: 2),
        child: Column(
          children: [
            movie.backdropPath == null
                ? SizedBox(
                    height: (MediaQuery.of(context).size.height / 3),
                    child: Center(
                        child: CircularProgressIndicator(
                      color: secondColor,
                    )),
                  )
                : Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: const [
                        // BoxShadow(
                        //   color: const Color.fromARGB(255, 34, 33, 33)
                        //       .withOpacity(0.1),
                        //   spreadRadius: 2,
                        //   blurRadius: 3,
                        //   offset:
                        //       const Offset(0, 5), // changes position of shadow
                        // ),
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
                        imageUrl:
                            "https://image.tmdb.org/t/p/w500${movie.backdropPath ?? ""}",
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

                        //  Center(
                        //     child: CircularProgressIndicator(
                        //   color: thirdCOlor,
                        // )),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
            //  Image.network(
            //   modelImages.img!,
            //   width: double.infinity,
            //   height: MediaQuery.of(context).size.height * 0.5,
            //   fit: BoxFit.cover,
            // )

            const SizedBox(
              height: 5,
            ),
            Text(
              movie.title!,
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
                    movie.releaseDate!.toString().substring(0, 4),
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
                            movie.voteAverage!.toString(),
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ))
              ],
            ),

            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Text(
            //     movie.overview!,
            //     style: const TextStyle(fontSize: 12, color: Colors.white),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
