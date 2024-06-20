part of 'audio_music_bloc.dart';

@immutable
sealed class AudioMusicEvent {}

class InitMusic extends AudioMusicEvent {}

class PlayMusic extends AudioMusicEvent {}

class UpdatePosition extends AudioMusicEvent {}

class PauseMusic extends AudioMusicEvent {}

class StopMusic extends AudioMusicEvent {}

class ReplayMusic extends AudioMusicEvent {}

class InitListMusic extends AudioMusicEvent {}

class SeekMusic extends AudioMusicEvent {
  Duration position;

  SeekMusic({required this.position});
}

class NextMusic extends AudioMusicEvent {}

class PrevMusic extends AudioMusicEvent {}

class SelectMusic extends AudioMusicEvent {
  int numberRun;

  SelectMusic({required this.numberRun});
}


