part of 'audio_music_bloc.dart';

@immutable
sealed class AudioMusicState {}

class AudioMusicInitial extends AudioMusicState {}

class AudioMusicInit extends AudioMusicState {
  ModelMusic modelMusic;

  AudioMusicInit({required this.modelMusic});
}



class InitAudioListMusicState extends AudioMusicState {
  List<ModelMusic> listMusic = [];
  int numberRun;

  InitAudioListMusicState({required this.listMusic,required this.numberRun});
}

class UpdatePositionState extends AudioMusicState {
  Duration position;
  Duration duration;
  bool isRun;
  ModelMusic modelMusic;
  int numberRun;

  UpdatePositionState(
      {required this.position, required this.isRun, required this.duration,required this.modelMusic,required this.numberRun});
}

// class UpdateMusicState extends AudioMusicState {
//   ModelMusic modelMusic;

//   UpdateMusicState({required this.modelMusic});
// }
