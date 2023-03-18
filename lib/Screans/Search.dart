import 'package:fixflex/Controllers/getData.dart';
import 'package:fixflex/Models/TvShow.dart';
import 'package:fixflex/Models/movies.dart';
import 'package:fixflex/Screans/CardImage.dart';
import 'package:fixflex/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final focusNode = FocusNode();

  late TextEditingController controller;
  OverlayEntry? entry;
  // for scroll
  final layerLink = LayerLink();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: SafeArea(
            child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              10.h,
              searchBar(),
              fillter(),
              isMovie ? resultMovies() : resultTvShow(),
            ],
          ),
        )));
  }

  FutureBuilder<List<ResultsMovie>> resultMovies() {
    return FutureBuilder(
        future: GetData().searchMovie(controller.text),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(color: secondColor),
            );
          } else {
            List movies = [];
            for (var element in snapshot.data!) {
              if (movies.indexWhere((e) => element.id == e.id!) == -1) {
                movies.add(element);
              }
            }
            return AnimationLimiter(
              child: StaggeredGridView.countBuilder(
                  staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                  physics: const BouncingScrollPhysics(),
                  mainAxisSpacing: 8,
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  itemCount: movies.length,
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
                          child: ItemImage(movie: movies[index]),
                        ),
                      ),
                    );
                  }),
            );
          }
        });
  }

  FutureBuilder<List<ResultsTvShow>> resultTvShow() {
    return FutureBuilder(
        future: GetData().searchTvshow(controller.text),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(color: secondColor),
            );
          } else {
            List tvShow = [];
            for (var element in snapshot.data!) {
              if (tvShow.indexWhere((e) => element.id == e.id!) == -1) {
                tvShow.add(element);
              }
            }
            return AnimationLimiter(
              child: StaggeredGridView.countBuilder(
                  staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                  physics: const BouncingScrollPhysics(),
                  mainAxisSpacing: 8,
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  itemCount: tvShow.length,
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
                          child: ItemImage(tvShow: tvShow[index]),
                        ),
                      ),
                    );
                  }),
            );
          }
        });
  }

  bool isMovie = true;
  Widget fillter() {
    return Row(
      children: [
        10.w,
        RawMaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          onPressed: () {
            isMovie = true;
            setState(() {});
          },
          fillColor: isMovie ? secondColor : Colors.grey.shade500,
          splashColor: Colors.white,
          child: const Text(
            'Movies',
            style: TextStyle(color: Colors.white),
          ),
        ),
        10.w,
        RawMaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          onPressed: () {
            isMovie = false;
            setState(() {});
          },
          splashColor: Colors.white,
          fillColor: !isMovie ? secondColor : Colors.grey.shade500,
          child: const Text(
            'TV Show',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  List<ResultsMovie> result = [];
  Widget searchBar() {
    return Theme(
      data: ThemeData(
        textTheme: const TextTheme(
          // Set the text color of the input field
          subtitle1: TextStyle(color: Colors.red),
        ),
      ),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        onChanged: (value) {
          setState(() {});
        },
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                borderSide: BorderSide(color: secondColor, width: 2)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            prefixIcon: backbutton(context, secondColor),
            hintStyle: const TextStyle(
              color: Colors.red, // Set the text color to red
              fontFamily: 'OpenSans',
            ),
            labelStyle: TextStyle(color: secondColor),
            label: Text(
              'Search ',
              style: TextStyle(color: secondColor, fontSize: 25),
            )),
      ),
    );
  }
}
