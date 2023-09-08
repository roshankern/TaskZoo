import 'package:flutter/material.dart';
import 'package:dimensions_theme/dimensions_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskzoo/misc/theme_notifier.dart';

import 'package:taskzoo/widgets/onboarding/custom_nav_bar.dart';
import 'package:taskzoo/widgets/onboarding/incrementing_item.dart';
import 'package:taskzoo/widgets/onboarding/onboarding_page.dart';
import 'package:taskzoo/widgets/onboarding/tutorial_task_cards.dart';
import 'package:taskzoo/widgets/onboarding/tutorial_animal_builder.dart';
import 'package:taskzoo/widgets/onboarding/allow_notis_card.dart';

class OnboardingScreen extends StatefulWidget {
  final bool isFirstTime;
  final ThemeNotifier _themeNotifier;

  OnboardingScreen(this.isFirstTime, this._themeNotifier);

  @override
  _OnboardingScreenState createState() =>
      _OnboardingScreenState(isFirstTime: isFirstTime);
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final bool isFirstTime;
  int currentIndex = 0;
  final PageController _pageController = PageController();

  _OnboardingScreenState({required this.isFirstTime});

  void onTap(int index) {
    // You can use isFirstTime within this class now
    setState(() {
      currentIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget onboarding_page_1 = OnboardingPage(
        title: "Create Tasks",
        topBackgroundColor: "#FFA06B",
        animalSvgPath: "assets/onboarding/llama.svg",
        content: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.of(context).insets.medium),
            child: const Text(
              "Create tasks for your goals, and use filters to stay organized.",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SvgPicture.asset("assets/custom_icons/filter.svg",
                color: Theme.of(context).iconTheme.color,
                semanticsLabel: 'Filter'),
            Container(
              width: 1,
              height: 40,
              color: Theme.of(context).indicatorColor,
              margin: EdgeInsets.symmetric(
                  horizontal: Dimensions.of(context).insets.large),
            ),
            SvgPicture.asset("assets/custom_icons/plus.svg",
                color: Theme.of(context).iconTheme.color,
                semanticsLabel: 'Plus'),
          ]),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.of(context).insets.medium),
            child: const Text(
              "Boost productivity with daily, weekly, and monthly tasks.",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).indicatorColor,
                  width: Dimensions.of(context).borderWidths.small,
                ),
              ),
              child: Center(
                child: Text(
                  "D",
                  style: TextStyle(
                    color: Theme.of(context).indicatorColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(width: Dimensions.of(context).insets.small),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).indicatorColor,
                  width: Dimensions.of(context).borderWidths.small,
                ),
                color: Theme.of(context).cardColor,
              ),
              child: Center(
                child: Text(
                  "W",
                  style: TextStyle(
                    color: Theme.of(context).indicatorColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(width: Dimensions.of(context).insets.small),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).indicatorColor,
                  width: Dimensions.of(context).borderWidths.small,
                ),
                color: Theme.of(context).cardColor,
              ),
              child: Center(
                child: Text(
                  "M",
                  style: TextStyle(
                    color: Theme.of(context).indicatorColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ]),
        ]);

    Widget onboarding_page_2 = OnboardingPage(
        title: "Use Tasks",
        topBackgroundColor: "#45DAFF",
        animalSvgPath: "assets/onboarding/flamingo.svg",
        content: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.of(context).insets.medium),
            child: const Text(
              "Hold a task to mark it as complete, tap to edit or delete.",
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: Dimensions.of(context).insets.medium,
          ),
          Container(
              padding: EdgeInsets.all(Dimensions.of(context).insets.medium),
              color: Theme.of(context).scaffoldBackgroundColor,
              child: SingleChildScrollView(
                child: Row(
                  children: [
                    Expanded(
                        child: AspectRatio(
                            aspectRatio: 1, child: HoldingTaskCard())),
                    SizedBox(width: Dimensions.of(context).insets.medium),
                    Expanded(
                        child: AspectRatio(
                            aspectRatio: 1, child: FlippingTaskCard())),
                  ],
                ),
              )),
        ]);

    Widget onboarding_page_3 = OnboardingPage(
        title: "Collect Pieces",
        topBackgroundColor: "#85FF91",
        animalSvgPath: "assets/onboarding/parrot.svg",
        content: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.of(context).insets.medium),
            width: double.infinity,
            child: const Text(
              "Earn pieces for completing tasks!",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/custom_icons/puzzle_piece.svg",
                color: Theme.of(context).iconTheme.color,
                semanticsLabel: 'Puzzle Piece',
                width: 40.0,
                height: 40.0,
              ),
              SizedBox(width: Dimensions.of(context).insets.large),
              IncrementingDigitWidget(widget._themeNotifier),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.of(context).insets.medium),
            width: double.infinity,
            child: const Text(
              "Tasks from larger timelines earn more pieces.",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ]);

    Widget onboarding_page_4 = OnboardingPage(
        title: "Build Animals",
        topBackgroundColor: "#FFEDA8",
        animalSvgPath: "assets/onboarding/lion.svg",
        content: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.of(context).insets.medium),
            width: double.infinity,
            child: const Text(
              "Tap an animal to use collected pieces.",
              style: TextStyle(fontSize: 20),
            ),
          ),
          TutorialAnimalBuilder(svgPath: "assets/onboarding/rat.svg"),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.of(context).insets.medium),
            width: double.infinity,
            child: const Text(
              "Completed animals join your zoo!",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ]);

    Widget onboarding_page_5 = OnboardingPage(
        title: "Get Reminders",
        topBackgroundColor: "#AC90E0",
        animalSvgPath: "assets/onboarding/jellyfish.svg",
        content: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.of(context).insets.medium),
            child: const Text(
              "Allow TaskZoo notifications for helpful future nudges.",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            padding: EdgeInsets.all(Dimensions.of(context).insets.medium),
            color: Theme.of(context).scaffoldBackgroundColor,
            child: AllowNotisCard(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.of(context).insets.medium),
            child: const Text(
              "Set reminders for each task to never forget your goals!",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ]);

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        children: [
          onboarding_page_1,
          onboarding_page_2,
          onboarding_page_3,
          onboarding_page_4,
          onboarding_page_5
        ],
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: currentIndex,
        onTap: onTap,
        isFirstTime: widget.isFirstTime,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
