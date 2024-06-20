import 'dart:async';
import 'dart:math';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:internshipmigi/blocs/play_music/audio_music_bloc.dart';
import 'package:internshipmigi/constants/app_colors.dart';
import 'package:internshipmigi/constants/app_text_style.dart';
import 'package:internshipmigi/constants/image.dart';
import 'package:internshipmigi/models/music_song.dart';
import 'package:internshipmigi/screens/audio/widgets/app_bar.dart';
import 'package:internshipmigi/screens/audio/widgets/show_avata_play_music.dart';
import 'package:internshipmigi/services/audio_music_repo.dart';
import 'package:internshipmigi/services/loger.dart';

class PlayMusicScreen extends StatefulWidget {
  const PlayMusicScreen({super.key});

  @override
  State<PlayMusicScreen> createState() => _PlayMusicScreenState();
}

class _PlayMusicScreenState extends State<PlayMusicScreen> {
  Duration _seconds = Duration.zero;
  Duration _currentTime = Duration.zero;
  bool _isRun = false;
  AudioPlayer player = AudioPlayer();
  String url =
      'https://onlinetestcase.com/wp-content/uploads/2023/06/2-MB-MP3.mp3';

   ModelMusic? _modelMusic;

  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    BlocProvider.of<AudioMusicBloc>(context).close();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: BlocBuilder<AudioMusicBloc, AudioMusicState>(
        builder: (context, state) {
          logger.log(state);
          if (state is AudioMusicInit) {
            _modelMusic = state.modelMusic;
          } else if (state is UpdatePositionState){
            _modelMusic = state.modelMusic;
          }
          return AppBarPlayMusic(
              singerName: 'Ariana Grande',
              songName: _modelMusic!=null ? _modelMusic!.title : '...');
              // songName: "Nguyễn Thế Thái Thái Thái Thái Thái Thái");
          
        },
      )),
      backgroundColor: AppColors.white,
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height * 0.85,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ShowAvatarPlayMusic(),
              BlocBuilder<AudioMusicBloc, AudioMusicState>(
                builder: (context, state) {
                  if (state is UpdatePositionState) {
                    _currentTime = state.position;
                    _seconds = state.duration;
                  } 
                  

                  return Column(
                    children: [
                      ProgressBar(
                        thumbColor: AppColors.runMusic,
                        progressBarColor: AppColors.runMusic,
                        progress: _currentTime,
                        // buffered: Duration(milliseconds: 2000),
                        total: _seconds,
                        onSeek: (duration) {
                          BlocProvider.of<AudioMusicBloc>(context).add(SeekMusic(position: duration));
                        },
                      ),
                    ],
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  itemPlayFeatures(
                    path: Images.ic_replay,
                    onTap: () {
                      BlocProvider.of<AudioMusicBloc>(context).add(ReplayMusic());
                    },
                  ),
                  itemPlayFeatures(
                    path: Images.ic_prew,
                    onTap: () {
                      BlocProvider.of<AudioMusicBloc>(context).add(PrevMusic());
                    },
                  ),
                  BlocBuilder<AudioMusicBloc, AudioMusicState>(
                      builder: (context, state) {
                    print(state.toString());

                    if (state is UpdatePositionState) {
                      _isRun = state.isRun;
                    }
                    return itemPlays(
                      path: !_isRun ? Images.ic_play : Images.ic_pause,
                      onTap: () {
                        !_isRun
                            ? BlocProvider.of<AudioMusicBloc>(context).add(PlayMusic())
                            : BlocProvider.of<AudioMusicBloc>(context).add(PauseMusic());
                      },
                    );
                  }),
                  itemPlayFeatures(
                    path: Images.ic_next,
                    onTap: () {
                      BlocProvider.of<AudioMusicBloc>(context).add(NextMusic());
                    },
                  ),
                  itemPlayFeatures(
                    path: Images.ic_favourite_music,
                    onTap: () {},
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  String _formatDuration(double seconds) {
    Duration duration = Duration(seconds: seconds.toInt());
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  Widget itemPlayFeatures({required String path, required Function() onTap}) {
    return InkWell(
      borderRadius: BorderRadius.circular(55),
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: SvgPicture.asset(
          path,
          color: AppColors.runMusic,
        ),
      ),
    );
  }

  Widget itemPlays({required String path, required Function() onTap}) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        height: 62,
        width: 62,
        padding: EdgeInsets.all(_isRun ? 1 : 5),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          path,
          color: AppColors.runMusic,
        ),
      ),
    );
  }
}
