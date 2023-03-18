import 'package:fixflex/Controllers/getData.dart';
import 'package:fixflex/Models/movies.dart';
import 'package:fixflex/Screans/CardImage.dart';
import 'package:fixflex/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class AllMovies extends StatefulWidget {
  const AllMovies({super.key});

  @override
  State<AllMovies> createState() => _AllMoviesState();
}

class _AllMoviesState extends State<AllMovies> {
  int indexp = 0;
  int nbrPage = 1;
  List<ResultsMovie> movies = [];
  final ScrollController _scrollController = ScrollController();

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        leading: backbutton(context, secondColor),
      ),
      backgroundColor: primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [getMovies(), 20.h, numberPage(), 100.h],
          ),
        ),
      ),
    );
  }

  SizedBox numberPage() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        itemCount: 500,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: RawMaterialButton(
              onPressed: () {
                if (index % 2 != 0) {
                  indexp = 10;
                } else {
                  nbrPage = index;
                  indexp = 0;
                }
                _scrollToTop();
                setState(() {});
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              fillColor: secondColor,
              splashColor: Colors.white,
              child: FittedBox(
                  child: Text(
                'Page ${index + 1}',
                style: const TextStyle(color: Colors.white),
              )),
            ),
          );
        },
      ),
    );
  }

  Widget getMovies() {
    return FutureBuilder(
        future: GetData().getPageIndex('$nbrPage'),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(color: secondColor),
            );
          } else {
            movies = [];
            for (var element in snapshot.data!.results!) {
              if (movies.indexWhere((e) => element.id == e.id!) == -1) {
                movies.add(element);
              }
            }

            // GetBest().getBestFive(list);
            return AnimationLimiter(
              child: StaggeredGridView.countBuilder(
                  staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                  physics: const BouncingScrollPhysics(),
                  mainAxisSpacing: 8,
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  itemCount: movies.length ~/ 2,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 500),
                      columnCount: 2,
                      child: ScaleAnimation(
                        duration: const Duration(milliseconds: 900),
                        curve: Curves.fastLinearToSlowEaseIn,
                        child: FadeInAnimation(
                          child: ItemImage(
                            movie: movies[index + indexp],
                          ),
                        ),
                      ),
                    );
                  }),
            );
          }
        });
  }
}
