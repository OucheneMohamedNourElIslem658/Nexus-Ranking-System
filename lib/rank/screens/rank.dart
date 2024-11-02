import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nexus_ranking_system/constents/custom_colors.dart';
import 'package:nexus_ranking_system/rank/widgets/elite_ranking.dart';
import 'package:nexus_ranking_system/rank/widgets/filtering_button.dart';
import 'package:nexus_ranking_system/rank/widgets/rest_of_members.dart';
import 'package:nexus_ranking_system/utils/app_bar_delegate.dart';

class RankScreen extends StatelessWidget {
  const RankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.black1,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              title: const Text(
                "Members Ranking",
              ),
              actions: [
                IconButton(
                  onPressed: (){}, 
                  icon: SvgPicture.asset('assets/icons/help.svg')
                )
              ],
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverAppBarDelegate(
                minHeight: 80, 
                maxHeight: 80, 
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: FilteringButton(
                      onChanged: (value) {},
                      filters: const [Filter.mobileBack, Filter.webFront, Filter.mobileFront],
                      initialFilter: Filter.mobileBack,
                    ),
                  ),
                ),
              )
            ),
          ], 
          body: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EleteRanking(),
                  SizedBox(height: 30),
                  RestOfMembers(),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}