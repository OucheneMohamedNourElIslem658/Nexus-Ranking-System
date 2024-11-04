import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nexus_ranking_system/features/auth/repos/auth.dart';
import 'package:nexus_ranking_system/constents/text_styles.dart';

class GithubSignInButton extends StatelessWidget {
  const GithubSignInButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: (){},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/icons/github.svg',
            // ignore: deprecated_member_use
            color: Colors.white,
            width: 30,
          ),
          const SizedBox(width: 10),
          const Text(
            'Sign In with Github',
            style: TextStyles.style11,
          ),
        ],
      ),
    );
  }
}

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async => AuthRepo.signInWithGoogle(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/icons/google.svg',
            width: 30,
          ),
          const SizedBox(width: 10),
          const Flexible(
            child: Text(
              'Sign In with Google',
              style: TextStyles.style11,
            ),
          ),
        ],
      ),
    );
  }
}