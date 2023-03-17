import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Color primaryColor = const Color.fromARGB(217, 0, 0, 0);
Color secondColor = const Color.fromARGB(255, 231, 22, 7);

Widget backbutton(BuildContext context, Color color) {
  return RawMaterialButton(
      shape: const CircleBorder(),
      splashColor: Colors.white,
      //fillColor: Colors.yellow.shade300,
      onPressed: () {
        Navigator.of(context).pop();
      },
      // ignore: prefer_const_constructors
      child: Icon(
        FontAwesomeIcons.circleChevronLeft,
        size: 30,
        color: color,
      ));
}

extension EmptyPadding on num {
  SizedBox get h => SizedBox(
        height: toDouble(),
      );
  SizedBox get w => SizedBox(
        width: toDouble(),
      );
}
