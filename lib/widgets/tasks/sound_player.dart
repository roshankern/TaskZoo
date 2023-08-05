import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

class SoundPlayer {
  Soundpool? _pool;
  int? _soundId;

  SoundPlayer() {
    _init();
  }

  Future<void> _init() async {
    _pool = Soundpool(streamType: StreamType.notification);
    var asset = await rootBundle.load("assets/TaskCompletion.wav");
    _soundId = await _pool!.load(asset);
  }

  Future<void> playSound() async {
    if (_soundId == null || _pool == null) {
      throw "Sound not loaded";
    }
    _pool!.play(_soundId!);
  }
}
