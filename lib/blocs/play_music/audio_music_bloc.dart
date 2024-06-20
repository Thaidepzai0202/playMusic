import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:internshipmigi/models/music_song.dart';
import 'package:internshipmigi/services/audio_music_repo.dart';
import 'package:internshipmigi/services/loger.dart';
import 'package:meta/meta.dart';

part 'audio_music_event.dart';
part 'audio_music_state.dart';

class AudioMusicBloc extends Bloc<AudioMusicEvent, AudioMusicState> {
  AudioPlayer _player = AudioPlayer();
  Duration _time = Duration.zero;
  Duration _position = Duration.zero;
  List<ModelMusic> listMusic = [];
  bool _isRun = false;
  int _numberRun = 0;

  AudioMusicBloc() : super(AudioMusicInitial()) {
    _player.onDurationChanged.listen((event) {
      _time = event;
    });

    _player.onPositionChanged.listen((event) async {
      logger.log(event.toString());
      _position = event;
      add(UpdatePosition());
      if (_position.inSeconds.toInt() >= _time.inSeconds.toInt())
        add(StopMusic());
    });

    on<AudioMusicEvent>((event, emit) {});
    on<InitMusic>(_onInitMusic);
    on<PauseMusic>(_onPauseMusic);
    on<PlayMusic>(_onPlayMusic);
    on<UpdatePosition>(_onUpdatePositionMusic);
    on<StopMusic>(_onStopMusic);
    on<ReplayMusic>(_onReplayMusic);
    on<InitListMusic>(_onInitListMusic);
    on<SeekMusic>(_onSeekMusic);
    on<NextMusic>(_onNextMusic);
    on<PrevMusic>(_onPrevMusic);
    on<SelectMusic>(_onPSelectMusic);
  }
  Future<void> _onInitMusic(
      InitMusic event, Emitter<AudioMusicState> emit) async {
    try {
      listMusic = await AudioMusicRepo()
          .getData('https://63eafe34f1a969340db02811.mockapi.io/list_audio');
      emit(AudioMusicInit(modelMusic: listMusic[_numberRun]));
      await _player.setSourceUrl(listMusic[_numberRun].path);
      logger.log(listMusic[_numberRun].path);
      // logger.log(time.toString());
    } catch (e) {
      print('alo alo $e');
    }
  }

  Future<void> _onPauseMusic(
      PauseMusic event, Emitter<AudioMusicState> emit) async {
    try {
      _isRun = false;
      await _player.pause();
      emit(UpdatePositionState(
          position: _position,
          isRun: _isRun,
          duration: _time,
          numberRun: _numberRun,
          modelMusic: listMusic[_numberRun]));
    } catch (e) {
      print(e);
    }
  }

  Future<void> _onPlayMusic(
      PlayMusic event, Emitter<AudioMusicState> emit) async {
    try {
      _isRun = true;
      await _player.play(UrlSource(listMusic[_numberRun].path));

      emit(UpdatePositionState(
          position: _position,
          isRun: _isRun,
          duration: _time,
          numberRun: _numberRun,
          modelMusic: listMusic[_numberRun]));
      logger.log(event.toString());
    } catch (e) {
      print(e);
    }
  }

  Future<void> _onReplayMusic(
      ReplayMusic event, Emitter<AudioMusicState> emit) async {
    try {
      _isRun = true;
      await _player.stop();
      await _player.play(UrlSource(listMusic[_numberRun].path));
      emit(UpdatePositionState(
          position: Duration.zero,
          isRun: _isRun,
          duration: _time,
          numberRun: _numberRun,
          modelMusic: listMusic[_numberRun]));
    } catch (e) {
      print(e);
    }
  }

  Future<void> _onStopMusic(
      StopMusic event, Emitter<AudioMusicState> emit) async {
    try {
      _isRun = false;
      await _player.stop();
      emit(UpdatePositionState(
          position: Duration.zero,
          isRun: _isRun,
          duration: _time,
          numberRun: _numberRun,
          modelMusic: listMusic[_numberRun]));
    } catch (e) {
      print(e);
    }
  }

  Future<void> _onInitListMusic(
      InitListMusic event, Emitter<AudioMusicState> emit) async {
    try {
      emit(
          InitAudioListMusicState(listMusic: listMusic, numberRun: _numberRun));
      logger.log(event.toString());
    } catch (e) {
      print(e);
    }
  }

  Future<void> _onUpdatePositionMusic(
      UpdatePosition event, Emitter<AudioMusicState> emit) async {
    try {
      emit(UpdatePositionState(
          position: _position,
          isRun: _isRun,
          duration: _time,
          numberRun: _numberRun,
          modelMusic: listMusic[_numberRun]));
      // logger.log(event.toString());
    } catch (e) {
      print(e);
    }
  }

  Future<void> _onSeekMusic(
      SeekMusic event, Emitter<AudioMusicState> emit) async {
    try {
      _player.seek(event.position);

      emit(UpdatePositionState(
          position: event.position,
          isRun: _isRun,
          duration: _time,
          numberRun: _numberRun,
          modelMusic: listMusic[_numberRun]));
    } catch (e) {
      print(e);
    }
  }

  Future<void> _onNextMusic(
      NextMusic event, Emitter<AudioMusicState> emit) async {
    try {
      if (_numberRun == listMusic.length-1) {_numberRun=0;}
      else{_numberRun++;}
        _isRun = true;
        await _player.stop();
        // await _player.setSourceUrl(listMusic[_numberRun].path);
        emit(UpdatePositionState(
            position: Duration.zero,
            isRun: _isRun,
            duration: _time,
            numberRun: _numberRun,
            modelMusic: listMusic[_numberRun]));
        await _player.play(UrlSource(listMusic[_numberRun].path));
        logger.log(event.toString());
      
    } catch (e) {
      print(e);
    }
  }

  Future<void> _onPrevMusic(
      PrevMusic event, Emitter<AudioMusicState> emit) async {
    try {
      if (_numberRun == 0) {
        _numberRun = listMusic.length - 1;
      } else {
        _numberRun--;
      }
      await _player.stop();
      // await _player.setSourceUrl(listMusic[_numberRun].path);
      _isRun = true;
      emit(UpdatePositionState(
          position: Duration.zero,
          isRun: _isRun,
          duration: _time,
          numberRun: _numberRun,
          modelMusic: listMusic[_numberRun]));
      await _player.play(UrlSource(listMusic[_numberRun].path));

      logger.log(event.toString());
    } catch (e) {
      print(e);
    }
  }

  Future<void> _onPSelectMusic(
      SelectMusic event, Emitter<AudioMusicState> emit) async {
    try {
      if (_numberRun > 0) {
        await _player.stop();
        await _player.setSourceUrl(listMusic[_numberRun].path);
        _numberRun--;
        _isRun = true;
        emit(UpdatePositionState(
            position: Duration.zero,
            isRun: _isRun,
            duration: _time,
            numberRun: _numberRun,
            modelMusic: listMusic[_numberRun]));
        await _player.play(UrlSource(listMusic[_numberRun].path));

        logger.log(event.toString());
      }
      _numberRun = event.numberRun;
      await _player.stop();
      await _player.setSourceUrl(listMusic[_numberRun].path);
      _isRun = true;
      emit(UpdatePositionState(
          position: Duration.zero,
          isRun: _isRun,
          duration: _time,
          numberRun: _numberRun,
          modelMusic: listMusic[_numberRun]));
      await _player.play(UrlSource(listMusic[_numberRun].path));

      logger.log(event.toString());
    } catch (e) {
      print(e);
    }
  }
}
