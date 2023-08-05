import 'package:flutter/material.dart';

class HapticNotifier with ChangeNotifier {
  int hapticStatus = 0;

  int get hapticValue => hapticStatus;

  void toggleHaptic() {
    hapticStatus = hapticStatus == 0 ? 1 : 0;
    notifyListeners();
  }
}
