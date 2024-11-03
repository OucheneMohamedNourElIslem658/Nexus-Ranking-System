import 'package:flutter/material.dart';
import 'package:nexus_ranking_system/constents/custom_colors.dart';

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: LinearProgressIndicator(
            color: CustomColors.purple1,
            backgroundColor: CustomColors.black1,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
    );
  }
}