import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  late SharedPreferences prefs;
  final StreamController<int> _totalCollectedPiecesController =
      StreamController<int>.broadcast();

  PreferenceService() {
    initialize();
  }

  Future<void> initialize() async {
    prefs = await SharedPreferences.getInstance();
    _totalCollectedPiecesController.sink
        .add(prefs.getInt('totalCollectedPieces') ?? 0);
  }

  Stream<int> get totalCollectedPiecesStream =>
      _totalCollectedPiecesController.stream;

  Future<int> getTotalCollectedPieces() async {
    int totalCollectedPieces = prefs.getInt('totalCollectedPieces') ?? 0;
    _totalCollectedPiecesController
        .add(totalCollectedPieces); // emit the new value
    return totalCollectedPieces;
  }

  Future<void> setTotalCollectedPieces(int value) async {
    await prefs.setInt('totalCollectedPieces', value);
    _totalCollectedPiecesController.add(value); // emit the new value
  }

  void dispose() {
    _totalCollectedPiecesController.close();
  }
}
