import 'package:flutter/material.dart';
import 'package:nexus_ranking_system/features/auth/repos/oauth_sign_in_buttons.dart';
import 'package:nexus_ranking_system/constents/custom_colors.dart';
import 'package:nexus_ranking_system/constents/text_styles.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome Wizard!",
              style: TextStyles.style10,
            ),
            const SizedBox(height: 10),
            Text(
              "Sign In to see your rank",
              style: TextStyles.style2.copyWith(
                color: CustomColors.grey1
              ),
            ),
            const SizedBox(height: 50),
            const GoogleSignInButton(),
          ],
        ),
      ),
    );
  }
}