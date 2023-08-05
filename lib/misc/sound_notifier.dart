import 'package:flutter/material.dart';

class SoundNotifer with ChangeNotifier {
  int soundStatus = 0;

  int get soundValue => soundStatus;

  void toggleSound() {
    soundStatus = (soundStatus == 0) ? 1 : 0;
    notifyListeners();
  }
}
