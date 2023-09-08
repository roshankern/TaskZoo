import 'package:dimensions_theme/dimensions_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AllowNotisCard extends StatefulWidget {
  @override
  _AllowNotisCardState createState() => _AllowNotisCardState();
}

class _AllowNotisCardState extends State<AllowNotisCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _borderAnimation;
  double currentBorderWidth = 1.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _borderAnimation = Tween<double>(begin: 1.0, end: 3.0).animate(_controller)
      ..addListener(() {
        setState(() {
          currentBorderWidth = _borderAnimation.value;
        });
      });

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void askForNotiPerms() {
    print("ask for notis permission");
    _controller.stop();
    setState(() {
      currentBorderWidth = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        askForNotiPerms();
      },
      child: Container(
        padding: EdgeInsets.all(Dimensions.of(context).insets.medium),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius:
              BorderRadius.circular(Dimensions.of(context).radii.medium),
          border: Border.all(
            color: Theme.of(context).indicatorColor,
            width: currentBorderWidth,
          ),
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
