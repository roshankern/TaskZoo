import 'package:flutter/material.dart';

class ZooPage extends StatefulWidget {
  const ZooPage({Key? key}) : super(key: key);

  @override
  _ZooPageState createState() => _ZooPageState();
}

class _ZooPageState extends State<ZooPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Zoo', style: Theme.of(context).textTheme.headline4),
    );
  }
}
