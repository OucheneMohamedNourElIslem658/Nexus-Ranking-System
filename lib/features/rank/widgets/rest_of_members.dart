import 'package:flutter/material.dart';
import 'package:nexus_ranking_system/constents/custom_colors.dart';
import 'package:nexus_ranking_system/constents/text_styles.dart';

class RestOfMembers extends StatelessWidget {
  const RestOfMembers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Rest of members',
            style: TextStyles.style7,
          ),
          const SizedBox(height: 15),
          Column(
            children: List.generate(
              10,
              (index) => Padding(
                padding: EdgeInsets.only(top: index != 0 ? 10 : 0),
                child: MemberItem(
                  name: 'You',
                  email: 'm_ouchene@estin.dz',
                  rank: 100,
                  isMe: index == 0,
                ),
              )
            ),
          )
        ],
      ),
    );
  }
}

class MemberItem extends StatelessWidget {
  const MemberItem({
    super.key, 
    required this.name, 
    required this.email, 
    required this.rank, 
    this.isMe = false,
  });

  final String name;
  final String email;
  final int rank;
  final bool isMe;

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
                Text(
                  email,
                  style: TextStyles.style9,
                )
              ],
            )
          )
        ],
      ),
    );
  }
}