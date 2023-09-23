import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerService extends BaseAudioHandler {
  final _player = AudioPlayer();

  AudioPlayerService() {
    _player.setAsset("assets/TaskCompletion.wav");
  }

  @override
  Future<void> play() async {
    await _player.play();
    await super.play();
  }

  @override
  Future<void> pause() async {
    await _player.pause();
    await super.pause();
  }

  @override
  Future<void> stop() async {
    await _player.stop();
    await super.stop();
  }

  @override
  Future<void> seek(Duration position) async {
    await _player.seek(position);
    await super.seek(position);
  }

  @override
  Future<void> onTaskRemoved() async {
    await stop();
  }
}
