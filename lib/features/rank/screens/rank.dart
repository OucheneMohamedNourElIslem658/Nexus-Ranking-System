import 'package:flutter/material.dart';
import 'package:nexus_ranking_system/commun/repos/rank.dart';
import 'package:nexus_ranking_system/features/auth/repos/auth.dart';
import 'package:nexus_ranking_system/constents/custom_colors.dart';
import 'package:nexus_ranking_system/constents/text_styles.dart';
import 'package:nexus_ranking_system/features/rank/widgets/elite_ranking.dart';
import 'package:nexus_ranking_system/features/rank/widgets/filtering_button.dart';
import 'package:nexus_ranking_system/features/rank/widgets/rest_of_members.dart';
import 'package:nexus_ranking_system/models/member.dart';
import 'package:nexus_ranking_system/utils/app_bar_delegate.dart';
import 'package:url_launcher/url_launcher.dart';

class RankScreen extends StatelessWidget {
  const RankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.black1,
        drawer: const CustomDrawer(),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(), 
                icon: const Icon(
                  Icons.menu_rounded,
                  color: Colors.white,
                )
              ),
              title: const Text(
                "Members Ranking",
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverAppBarDelegate(
                minHeight: 80, 
                maxHeight: 80, 
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: DynamicFilteringButton(),
                  ),
                ),
              )
            ),
          ], 
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    EleteRanking(),
                    SizedBox(height: 30),
                    RestOfMembers(),
                    SizedBox(height: 20)
                  ],
                ),
              ),
            ),
          ),
        )
      ),
    );
  }
}

class DynamicFilteringButton extends StatelessWidget {
  const DynamicFilteringButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Field>?>(
      stream: RankRepo.getAllFieldsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting || snapshot.data == null) {
          return const SizedBox();
        }

        final fields = snapshot.data!;

        return FilteringButton(
          onChanged: (value) {},
          filters: fields,
          initialFilter: fields.first,
        );
      }
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthRepo.currentUser!;
    final currentUserPic = currentUser.photoURL;
    final email = currentUser.email;
    final name = currentUser.displayName;

    return Drawer(
      child: Column(
        children: [
          const SizedBox(height: 52),
          SizedBox(
            height: 100,
            width: 100,
            child: CircleAvatar(
              backgroundImage: currentUserPic != null 
                ? NetworkImage(currentUserPic) 
                : const AssetImage('assets/images/person_placeholder.png'),
              onBackgroundImageError: (exception, stackTrace) => const SizedBox.expand(),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            name ?? 'unnamed',
            textAlign: TextAlign.center,
            style: TextStyles.style7.copyWith(
              color: CustomColors.black1
            ),
          ),
          const SizedBox(height: 5),
          Text(
            email ?? 'undefined email',
          ),
          const SizedBox(height: 50),
          Column(
            children: [
              ListTile(
                leading: const Icon(Icons.logout_outlined),
                trailing: const Icon(Icons.arrow_forward_ios, size: 15,),
                onTap: () => AuthRepo.signOut(context),
                title: Text(
                  'Logout',
                  style: TextStyles.style8.copyWith(
                    color: CustomColors.black1
                  ),
                ),
              ),
              Container(
                width: double.maxFinite,
                height: 1,
                margin: const EdgeInsets.symmetric(horizontal: 25),
                color: CustomColors.grey1.withOpacity(0.3),
              ),
              ListTile(
                leading: const Icon(Icons.help_outline_rounded),
                trailing: const Icon(Icons.arrow_forward_ios, size: 15,),
                onTap: () async => await launchUrl(Uri.parse("mailto:m_ouchene@estin.dz&subject=Mobile App Error")),
                title: Text(
                  'Help',
                  style: TextStyles.style8.copyWith(
                    color: CustomColors.black1
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}