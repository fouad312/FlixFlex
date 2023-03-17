import 'package:fixflex/Controllers/getData.dart';
import 'package:fixflex/Models/movies.dart';
import 'package:fixflex/Screans/CardImage.dart';
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
    GetData().getAllData();
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
      body: FutureBuilder<Movie>(
        future: GetData().getAllData(),
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
            List<ItemImage> list = [];
            for (var element in snapshot.data!.results!) {
              // check if image exist
              // print(element.video);
              if (element.backdropPath != null) {
                list.add(ItemImage(movie: element));
              }
            }
            return AnimatedCard(list: list);
          }
        },
      ),
    );
  }
}
