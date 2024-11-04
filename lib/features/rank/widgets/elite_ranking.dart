import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nexus_ranking_system/commun/repos/rank.dart';
import 'package:nexus_ranking_system/constents/custom_colors.dart';
import 'package:nexus_ranking_system/constents/text_styles.dart';
import 'package:nexus_ranking_system/models/member.dart';

class EleteRanking extends StatelessWidget {
  const EleteRanking({
    super.key, 
    this.orderFieldID
  });

  final String? orderFieldID;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: StreamBuilder<List<Member>?>(
          stream: RankRepo.getMembersStream(limit: 3, orderFieldID: orderFieldID),
          builder: (context, snapshot) {
            final isWaiting = snapshot.connectionState == ConnectionState.waiting || snapshot.data == null;

            if (isWaiting) {
              return const Opacity(
                opacity: 0,
                child: LinearProgressIndicator()
              );
            }

            final members = snapshot.data!; 
            final firstMember = members.first;
            final secondMember = members[1];
            final thirdMember = members[2];

            return Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 4,
                  child: SecondMember(secondMember: secondMember)
                ),
                Expanded(
                  flex: 5,
                  child: FirstMember(firstMember: firstMember)
                ),
                Expanded(
                  flex: 4,
                  child: ThirdMember(thirdMember: thirdMember)
                )
              ],
            );
          }
        ),
      ),
    );
  }
}

class ThirdMember extends StatelessWidget {
  const ThirdMember({
    super.key,
    required this.thirdMember,
  });

  final Member thirdMember;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 70),
          child: Container(
            height: 150,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: CustomColors.black2,
              borderRadius: BorderRadius.horizontal(
                right: Radius.circular(15)
              )
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  thirdMember.name,
                  textAlign: TextAlign.center,
                  style: TextStyles.style5,
                ),
                const SizedBox(height: 7),
                Text(
                  '${thirdMember.totalScore}',
                  style: TextStyles.style6.copyWith(
                    color: CustomColors.orange3
                  ),
                ),
              ],
            ),
          ),
        ),
        Grade(
          imageURL: thirdMember.imageURL,
          addCrown: false,
          firstGradientColor: CustomColors.orange2,
          secondGradientColor: CustomColors.orange3,
        )
      ],
    );
  }
}

class FirstMember extends StatelessWidget {
  const FirstMember({
    super.key,
    required this.firstMember,
  });

  final Member firstMember;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Container(
            height: 200,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: CustomColors.black4,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(40)
              )
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  firstMember.name,
                  textAlign: TextAlign.center,
                  style: TextStyles.style5,
                ),
                const SizedBox(height: 7),
                Text(
                  '${firstMember.totalScore}',
                  style: TextStyles.style6,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 18),
          child: Grade(
            imageURL: firstMember.imageURL,
          ),
        )
      ],
    );
  }
}

class SecondMember extends StatelessWidget {
  const SecondMember({
    super.key,
    required this.secondMember,
  });

  final Member secondMember;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 70),
          child: Container(
            height: 165,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: CustomColors.black2,
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(15)
              )
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  secondMember.name,
                  textAlign: TextAlign.center,
                  style: TextStyles.style5,
                ),
                const SizedBox(height: 7),
                Text(
                  '${secondMember.totalScore}',
                  style: TextStyles.style6.copyWith(
                    color: CustomColors.red1
                  ),
                ),
              ],
            ),
          ),
        ),
        Grade(
          imageURL: secondMember.imageURL,
          addCrown: false,
          firstGradientColor: CustomColors.orange1,
          secondGradientColor: CustomColors.red1,
        ),
      ],
    );
  }
}

enum Grades {
  first,
  second,
  third
}

class Grade extends StatelessWidget {
  const Grade({
    super.key,
    this.addCrown = true,
    this.imageURL, 
    this.firstGradientColor = CustomColors.purple1, 
    this.secondGradientColor = CustomColors.pink1,
  });

  final bool addCrown;
  final String? imageURL;
  final Color firstGradientColor, secondGradientColor;

  @override
  Widget build(BuildContext context) {
    var linearGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        firstGradientColor,
        secondGradientColor
      ]
    );
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Padding(
          padding: addCrown 
            ? const EdgeInsets.only(top: 35, left: 18) 
            : EdgeInsets.zero,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Container(
                  height: 100,
                  width: 100,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: linearGradient
                  ),
                  child: CircleAvatar(
                    backgroundImage: imageURL != null 
                    ? NetworkImage(imageURL!) 
                    : const AssetImage('assets/images/person_placeholder.png'),
                  ),
                ),
              ),
              Transform.rotate(
                angle: 3.14/4,
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    gradient: linearGradient,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.center,
                  child: Transform.rotate(
                    angle: -3.14/4,
                    child: const Text(
                      '1',
                      style: TextStyles.style4,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        if (addCrown) SvgPicture.asset('assets/icons/crown.svg')
      ],
    );
  }
}