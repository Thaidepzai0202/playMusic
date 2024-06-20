import 'package:flutter/material.dart';


import 'package:internshipmigi/constants/app_colors.dart';

class AppTextStyles{
  static TextStyle musicNameText = TextStyle(
    color: AppColors.runMusic,
    fontSize: 18,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.normal
  );
  static TextStyle authorNameText = TextStyle(
    color: AppColors.runMusic,
    fontSize: 10,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w200
  );
  static TextStyle listMusicName = const TextStyle(
    color: AppColors.black,
    fontSize: 16,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold
  );
  static TextStyle musicAuthor = const TextStyle(
    color: AppColors.grayHint,
    fontSize: 12,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold,
  );
  static TextStyle musicTitle= const TextStyle(
    color: AppColors.black,
    fontSize: 14,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold
  );
}