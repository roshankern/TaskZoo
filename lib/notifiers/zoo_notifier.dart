import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ZooNotifier extends ChangeNotifier {
  int _currentBiome = 0;

  int get currentBiome => _currentBiome;

  void changeBiome(int newBiome) {
    _currentBiome = newBiome;
    notifyListeners();
  }
}