import 'package:flutter/material.dart';
import 'package:nexus_ranking_system/constents/text_styles.dart';

class Messengers {
  static void showSnackBar(BuildContext context, {required String message}){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyles.style7,
        ),
      )
    );
  }
}