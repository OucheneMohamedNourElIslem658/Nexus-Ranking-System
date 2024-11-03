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
    focusColor: Colors.white,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 100,vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        foregroundColor: Colors.white
      ),
    )
  );
}