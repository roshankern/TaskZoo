import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  final String imagePath;

  const BackgroundImage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black, Colors.transparent],
        ).createShader(Rect.fromLTRB(0, rect.height * 5/8, rect.width, rect.height));
      },
      blendMode: BlendMode.dstIn,
      child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
      ),
    );
  }
}
