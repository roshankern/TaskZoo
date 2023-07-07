import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  final String imagePath;

  const BackgroundImage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
        Container(
          height: 150,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Theme.of(context).scaffoldBackgroundColor,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
