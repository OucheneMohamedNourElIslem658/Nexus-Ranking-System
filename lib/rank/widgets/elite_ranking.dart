import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nexus_ranking_system/constents/custom_colors.dart';
import 'package:nexus_ranking_system/constents/text_styles.dart';

class EleteRanking extends StatelessWidget {
  const EleteRanking({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          flex: 4,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70),
                child: Container(
                  height: 165,
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
                      const Text(
                        'Rachel',
                        style: TextStyles.style5,
                      ),
                      const SizedBox(height: 7),
                      Text(
                        '1200',
                        style: TextStyles.style6.copyWith(
                          color: CustomColors.red1
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Grade(
                addCrown: false,
                firstGradientColor: CustomColors.orange1,
                secondGradientColor: CustomColors.red1,
              ),
            ],
          )
        ),
        Expanded(
          flex: 5,
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    color: CustomColors.black4,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(40)
                    )
                  ),
                  alignment: Alignment.center,
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Rachel',
                        style: TextStyles.style5,
                      ),
                      SizedBox(height: 7),
                      Text(
                        '1200',
                        style: TextStyles.style6,
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 4),
                child: Grade(),
              )
            ],
          )
        ),
        Expanded(
          flex: 4,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70),
                child: Container(
                  height: 150,
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
                      const Text(
                        'Rachel',
                        style: TextStyles.style5,
                      ),
                      const SizedBox(height: 7),
                      Text(
                        '1200',
                        style: TextStyles.style6.copyWith(
                          color: CustomColors.orange3
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Grade(
                addCrown: false,
                firstGradientColor: CustomColors.orange2,
                secondGradientColor: CustomColors.orange3,
              )
            ],
          )
        )
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