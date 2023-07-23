import 'package:flutter/material.dart';

class RearTaskCard extends StatelessWidget {
  final List<StreamTaskCardIcon> icons;

  const RearTaskCard({Key? key, required this.icons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: icons,
        ),
      ),
    );
  }
}

class StreamTaskCardIcon extends StatelessWidget {
  final Icon icon;
  final Stream<int> stream;

  StreamTaskCardIcon({
    Key? key,
    required this.icon,
    required this.stream,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(width: 8.0),
              Text(
                snapshot.data.toString(),
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
