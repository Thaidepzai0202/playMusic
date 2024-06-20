import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:internshipmigi/constants/app_colors.dart';
import 'package:internshipmigi/constants/app_text_style.dart';
import 'package:internshipmigi/constants/image.dart';

class SongItemWidget extends StatefulWidget {
  DateTime createdAt;
  String title;
  String image;
  String description;
  String path;
  String id;
  bool isChoose;
  Function() onTap;

  SongItemWidget({
    super.key,
    required this.createdAt,
    required this.title,
    required this.description,
    required this.id,
    required this.image,
    required this.path,
    required this.isChoose,
    required this.onTap
  });

  @override
  State<SongItemWidget> createState() => _SongItemWidgetState();
}

class _SongItemWidgetState extends State<SongItemWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.id,
              style: AppTextStyles.musicAuthor,
            ),
            SizedBox(
              height: 62,
              width: 62,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 137 / 360,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    style: AppTextStyles.musicTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.description,
                    style: AppTextStyles.musicAuthor,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 42,
              height: 17,
              child: widget.isChoose ? SvgPicture.asset(Images.ic_running_music) : SizedBox(),
            ),
            SvgPicture.asset(Images.ic_3_dot_column)
          ],
        ),
      ),
    );
  }
}
