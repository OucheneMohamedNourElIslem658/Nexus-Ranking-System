import 'package:flutter/material.dart';
import 'package:nexus_ranking_system/commun/repos/rank.dart';
import 'package:nexus_ranking_system/constents/custom_colors.dart';
import 'package:nexus_ranking_system/constents/text_styles.dart';
import 'package:nexus_ranking_system/features/auth/repos/auth.dart';
import 'package:nexus_ranking_system/models/member.dart';

class RestOfMembers extends StatelessWidget {
  const RestOfMembers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500),
      child: StreamBuilder<List<Member>?>(
        stream: RankRepo.getMembersStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }

          final members = snapshot.data ?? [];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'All members',
                style: TextStyles.style7,
              ),
              const SizedBox(height: 15),
              Column(
                children: List.generate(
                  members.length,
                  (index) {
                    final member = members[index];
                    final isMe = member.uid == AuthRepo.currentUser!.uid;
                    return Padding(
                      padding: EdgeInsets.only(top: index != 0 ? 10 : 0),
                      child: MemberItem(
                        name: !isMe ? member.name : 'You',
                        email: !isMe ? member.email : null,
                        rank: member.totalScore,
                        isMe: isMe,
                        score: member.totalScore,
                      ),
                    );
                  }
                ),
              )
            ],
          );
        }
      ),
    );
  }
}

class MemberItem extends StatelessWidget {
  const MemberItem({
    super.key, 
    required this.name, 
    this.email, 
    required this.rank, 
    required this.score,
    this.isMe = false,
  });

  final String name;
  final String? email;
  final int rank;
  final bool isMe;
  final int score;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
      decoration: BoxDecoration(
        color: !isMe ? CustomColors.black4 : null,
        borderRadius: BorderRadius.circular(20),
        gradient: isMe 
          ? const LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              CustomColors.purple1,
              CustomColors.pink1
            ]
          ) : null
      ),
      child: Row(
        children: [
          const SizedBox(
            height: 55,
            width: 55,
            child: CircleAvatar()
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyles.style8,
                ),
                if (email != null) Text(
                  email!,
                  style: TextStyles.style9,
                )
              ],
            )
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white)
            ),
            child: Text(
              score.toString(),
              style: TextStyles.style9.copyWith(
                color: Colors.white
              ),
            ),
          )
        ],
      ),
    );
  }
}