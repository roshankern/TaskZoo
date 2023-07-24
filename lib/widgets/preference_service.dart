import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  late SharedPreferences prefs;
  int _totalCollectedPieces = 0;

  final StreamController<int> _totalCollectedPiecesController =
      StreamController<int>.broadcast();

  PreferenceService() {
    _initialize();
  }

  Future<void> _initialize() async {
    prefs = await SharedPreferences.getInstance();
    _totalCollectedPieces = prefs.getInt('totalCollectedPieces') ?? 0;
    _totalCollectedPiecesController.add(_totalCollectedPieces);
  }

  int getTotalCollectedPieces() {
    return _totalCollectedPieces;
  }

  Stream<int> get totalCollectedPiecesStream =>
      _totalCollectedPiecesController.stream;

  Future<void> setTotalCollectedPieces(int value) async {
    await prefs.setInt('totalCollectedPieces', value);
    _totalCollectedPieces = value;
    _totalCollectedPiecesController
        .add(value); // Emit the new value to the stream
  }

  void dispose() {
    _totalCollectedPiecesController.close();
  }
}
