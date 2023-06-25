import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Settings', style: TextStyle(fontSize: 24)),
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
