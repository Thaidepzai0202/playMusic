import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:internshipmigi/constants/app_colors.dart';
import 'package:internshipmigi/constants/app_text_style.dart';
import 'package:internshipmigi/constants/image.dart';

class TitleMusicList extends StatefulWidget {
  String avatar;
  String listName;

  TitleMusicList({super.key, required this.avatar, required this.listName});

  @override
  State<TitleMusicList> createState() => _TitleMusicListState();
}

class _TitleMusicListState extends State<TitleMusicList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        children: [
          SizedBox(
            height: 176,
            width: MediaQuery.of(context).size.width * 140 / 360,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                widget.avatar,
                fit: BoxFit.cover,
              ),
            ),
          ),

          //name list music
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                Images.ic_heart,
                color: AppColors.runMusic,
              ),
              Container(
                alignment: Alignment.center,
                  width: 190,
                  height: 50,
                  child: Text(
                    widget.listName,
                    style: AppTextStyles.listMusicName,
                  )),
              SvgPicture.asset(
                Images.ic_download,
                color: AppColors.runMusic,
              ),
            ],
          )
        ],
      ),
    );
  }
}
