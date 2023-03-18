import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixflex/Athentification/Client.dart';
import 'package:fixflex/Componeents/animation/transitionAnimation.dart';
import 'package:fixflex/Controllers/Best.dart';
import 'package:fixflex/Controllers/getData.dart';
import 'package:fixflex/Models/TvShow.dart';
import 'package:fixflex/Models/movies.dart';
import 'package:fixflex/Screans/CardImage.dart';
import 'package:fixflex/Screans/Search.dart';
import 'package:fixflex/constant.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return const Center(
    //   child: Text('data'),
    // );
    return Scaffold(
      backgroundColor: primaryColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, SizeTransition2(const Search()));
        },
        backgroundColor: secondColor,
        child: const Icon(
          Icons.search_rounded,
          color: Colors.white,
        ),
      ),
      body: widgetScrean(),
    );
  }

  SingleChildScrollView bodyHome() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [getBestMovies(), getBestTvShow(), 200.h],
      ),
    );
  }

  Widget widgetScrean() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("clients")
            .where("uID",
                isEqualTo: FirebaseAuth.instance.currentUser != null
                    ? FirebaseAuth.instance.currentUser!.uid
                    : "vide")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Quelque chose s'est mal passé"));
          }

          if (snapshot.hasData) {
            if (snapshot.data!.docs.isNotEmpty) {
              var data = snapshot.data!.docs.first;

              client = Client.fromMap(data);

              return bodyHome();
            }
            //

          }
          return Center(
            child: CircularProgressIndicator(
              color: secondColor,
            ),
          );
        });
  }

  FutureBuilder<Movie> getBestMovies() {
    return FutureBuilder<Movie>(
      future: GetData().getPageIndex('1'),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Error'),
          );
        }
        if (!snapshot.hasData) {
          return Center(
              child: CircularProgressIndicator(
            color: secondColor,
          ));
        } else {
          List<ResultsMovie> list = [];
          for (var element in snapshot.data!.results!) {
            list.add(element);
          }
          GetBest().getBestFive(list);

          return AnimatedCard(
              title: "Best Movies",
              list: List.generate(5, (index) => ItemImage(movie: list[index])));
        }
      },
    );
  }

  FutureBuilder<TvShow> getBestTvShow() {
    return FutureBuilder<TvShow>(
      future: GetData().getTvShowPage('1'),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Error'),
          );
        }
        if (!snapshot.hasData) {
          return Center(
              child: CircularProgressIndicator(
            color: secondColor,
          ));
        } else {
          List<ResultsTvShow> list = [];
          for (var element in snapshot.data!.results!) {
            list.add(element);
          }
          GetBest().getBestFiveTvShow(list);

          return AnimatedCard(
              title: 'Best Tv Show',
              list:
                  List.generate(5, (index) => ItemImage(tvShow: list[index])));
        }
      },
    );
  }
}
