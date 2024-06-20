import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:internshipmigi/constants/app_colors.dart';
import 'package:internshipmigi/constants/image.dart';

class ShowAvatarPlayMusic extends StatefulWidget {
  const ShowAvatarPlayMusic({super.key});

  @override
  State<ShowAvatarPlayMusic> createState() => _ShowAvatarPlayMusicState();
}

class _ShowAvatarPlayMusicState extends State<ShowAvatarPlayMusic> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 316,
      height: 433,
      decoration: BoxDecoration(
          color: AppColors.backgroundAvatarMusic,
          borderRadius: BorderRadius.circular(30)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(Images.one_last_time),
          ),
          SizedBox(height: 30, child: SvgPicture.asset(Images.ic_3_dot)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(Images.ic_clock),
                SvgPicture.asset(Images.ic_download),
                SvgPicture.asset(Images.ic_heart),
              ],
            ),
          )
        ],
      ),
    );
    ;
  }
}
