import 'package:flutter/material.dart';

class Styles {
  static TextStyle splashTS = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 28,
    color: Colors.white,
  );

  static BoxDecoration splashGradient() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.red[900]!,
          Colors.white,
          Colors.blue[900]!,
        ],
        begin: const FractionalOffset(0, 0),
        end: const FractionalOffset(1, 0),
        stops: const [0, 0.5, 1],
        tileMode: TileMode.mirror,
      ),
    );
  }
}
