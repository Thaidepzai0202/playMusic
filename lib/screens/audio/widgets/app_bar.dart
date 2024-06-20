import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:internshipmigi/constants/app_text_style.dart';
import 'package:internshipmigi/constants/image.dart';
import 'package:internshipmigi/screens/audio/list_music_screen.dart';

class AppBarPlayMusic extends StatelessWidget {
  String songName;
  String singerName;
  AppBarPlayMusic(
      {super.key, required this.singerName, required this.songName});

  void onNavigatorListMusic(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ListMusicScreen()));
  }

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {},
          child: SvgPicture.asset(
            Images.ic_chevron_down,
            width: 24,
            height: 24,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Text(
                  songName,
                  style: AppTextStyles.musicNameText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  singerName,
                  style: AppTextStyles.authorNameText,
                ),
              ],
            ),
          ),
        ),
        InkWell(
            onTap: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => ListMusicScreen()));
              onNavigatorListMusic(context);
            },
            child: SvgPicture.asset(Images.ic_list_music))
      ],
    );
  }
}
