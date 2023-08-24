import 'package:dimensions_theme/dimensions_theme.dart';
import 'package:flutter/material.dart';
import 'package:taskzoo/widgets/zoo/test_animal_builder.dart';

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

  @override
  Widget build(BuildContext context) {
    // rest of the code
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
        return TestTutorialAnimalBuilder(
            svgPath: "assets/low_poly_curled_fox.svg");
      },
    );
  }
}
