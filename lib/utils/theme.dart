import 'package:flutter/material.dart';
import 'package:nexus_ranking_system/constents/custom_colors.dart';
import 'package:nexus_ranking_system/constents/text_styles.dart';

class CustomTheme {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: CustomColors.black1,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyles.style1
    ),
    focusColor: Colors.white
  );
}