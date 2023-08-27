import 'package:dimensions_theme/dimensions_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskzoo/widgets/zoo/test_animal_builder.dart';

import 'dart:ui' as ui;

class ZooTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zoo Test Page'),
      ),
      body: ListView(
        children: [
          ZooBody(),
        ],
      ),
    );
  }
}

class ZooBody extends StatelessWidget {
  ZooBody();

  final String svgAssetPath = "assets/racoon.svg";

  Future<String> loadSvgData() async {
    return await rootBundle.loadString(svgAssetPath);
  }

  Future<ui.Image> loadSvgImage() async {
    String svgStringData = await loadSvgData();

    PictureInfo pictureInfo =
        await vg.loadPicture(SvgStringLoader(svgStringData), null);
    ui.Image image = await pictureInfo.picture.toImage(1024, 1024);

    return image;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ui.Image>(
      future: loadSvgImage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final svgImageData = snapshot.data!;
          return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(Dimensions.of(context).insets.medium),
            itemCount: 10,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: Dimensions.of(context).insets.medium,
              mainAxisSpacing: Dimensions.of(context).insets.medium,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.all(10),
                width: 300,
                height: 300,
                color: Colors.blue,
                child: RawImage(
                  image: svgImageData,
                ),
              );
            },
          );
        }
      },
    );
  }
}
