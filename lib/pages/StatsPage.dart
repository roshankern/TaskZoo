import 'package:flutter/material.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Stats', style: TextStyle(fontSize: 24)),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 50,
        color: Theme.of(context).unselectedWidgetColor,
        child: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
