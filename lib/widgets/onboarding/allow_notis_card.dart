import 'package:dimensions_theme/dimensions_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AllowNotisCard extends StatefulWidget {
  @override
  _AllowNotisCardState createState() => _AllowNotisCardState();
}

class _AllowNotisCardState extends State<AllowNotisCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("ask for noti permission");
      },
      child: Container(
        padding: EdgeInsets.all(Dimensions.of(context).insets.medium),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius:
              BorderRadius.circular(Dimensions.of(context).radii.medium),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(
              "assets/custom_icons/notifications.svg",
              color: Theme.of(context).iconTheme.color,
              semanticsLabel: 'Notifications',
            ),
            const Text(
              "Allow Notifications",
              style: TextStyle(fontSize: 17),
            ),
            Icon(
              Icons.arrow_forward_ios,
            )
          ],
        ),
      ),
    );
  }
}
