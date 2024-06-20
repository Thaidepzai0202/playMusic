import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:internshipmigi/blocs/play_music/audio_music_bloc.dart';
import 'package:internshipmigi/constants/app_colors.dart';
import 'package:internshipmigi/constants/app_text_style.dart';
import 'package:internshipmigi/constants/image.dart';
import 'package:internshipmigi/models/music_song.dart';
import 'package:internshipmigi/screens/audio/widgets/circle_avatar.dart';
import 'package:internshipmigi/screens/audio/widgets/song_item.dart';
import 'package:internshipmigi/screens/audio/widgets/title_music_list.dart';
import 'package:internshipmigi/services/audio_music_repo.dart';
import 'package:internshipmigi/services/loger.dart';

class ListMusicScreen extends StatefulWidget {
  const ListMusicScreen({super.key});

  @override
  State<ListMusicScreen> createState() => _ListMusicScreenState();
}

class _ListMusicScreenState extends State<ListMusicScreen> {
  double turn = 0;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AudioMusicBloc>(context).add(InitListMusic());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          backgroundColor: AppColors.white,
          automaticallyImplyLeading: false,
          // leading: SizedBox(),
          title: InkWell(
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SvgPicture.asset(
              Images.ic_back,
              width: 30,
              height: 30,
            ),
          ),
        ),
        body: BlocBuilder<AudioMusicBloc, AudioMusicState>(
          builder: (context, state) {
            List<ModelMusic> listMusic =
                BlocProvider.of<AudioMusicBloc>(context).listMusic;
            int numberRun = 0;
            bool isRun = false;

            if (state is InitAudioListMusicState) {
              listMusic = state.listMusic;
              numberRun = state.numberRun;
            } else if (state is UpdatePositionState) {
              isRun = state.isRun;
              numberRun = state.numberRun;
              turn += 0.01;
            }
            return Column(
              children: [
                TitleMusicList(
                  avatar:
                      'https://toplist.vn/images/800px/taylor-swift-428409.jpg',
                  listName: 'Taylor Swift',
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: ListView.builder(
                      itemCount: listMusic.length,
                      itemBuilder: (context, index) {
                        return SongItemWidget(
                          onTap: () {
                            BlocProvider.of<AudioMusicBloc>(context)
                                .add(SelectMusic(numberRun: index));
                            numberRun = index;
                          },
                          createdAt: listMusic[index].createdAt,
                          title: listMusic[index].title,
                          description: listMusic[index].description,
                          id: listMusic[index].id,
                          image: listMusic[index].image,
                          path: listMusic[index].path,
                          isChoose: numberRun == index,
                        );
                      },
                    ),
                  ),
                ),
                if (listMusic.isNotEmpty)
                  Container(
                    color: AppColors.backgroundRunningMusic,
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: AppColors.tundora),
                          // child: ClipRRect(
                          //   borderRadius: BorderRadius.circular(30),
                          //   child: Image.network(
                          //     listMusic[numberRun].image,
                          //     fit: BoxFit.cover,
                          //     width: 46,
                          //     height: 46,
                          //   ),
                          // ),
                          child: CirCleAvatarAround(
                            turn: turn,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.network(
                                listMusic[numberRun].image,
                                fit: BoxFit.cover,
                                width: 46,
                                height: 46,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 56,
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(listMusic[numberRun].title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.listMusicName),
                              Text(
                                listMusic[numberRun].description,
                                style: AppTextStyles.musicAuthor,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            isRun
                                ? BlocProvider.of<AudioMusicBloc>(context)
                                    .add(PauseMusic())
                                : BlocProvider.of<AudioMusicBloc>(context)
                                    .add(PlayMusic());
                          },
                          child: SvgPicture.asset(
                            !isRun
                                ? Images.ic_play_small
                                : Images.ic_pause_small,
                            height: 30,
                            width: 30,
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              BlocProvider.of<AudioMusicBloc>(context)
                                  .add(NextMusic());
                            },
                            child: SvgPicture.asset(Images.ic_next)),
                      ],
                    ),
                  ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 40 / 800,
                )
              ],
            );
          },
        ));
  }
}

