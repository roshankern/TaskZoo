import 'package:flutter/material.dart';

class RearTaskCardIcon extends StatelessWidget {
  final Icon icon;
  final String text;

  const RearTaskCardIcon({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        const SizedBox(width: 8.0),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
