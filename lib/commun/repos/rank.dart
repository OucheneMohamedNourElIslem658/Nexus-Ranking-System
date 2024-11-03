import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nexus_ranking_system/models/member.dart';

class RankRepo {
  static final _firestore = FirebaseFirestore.instance;

  Stream<List<Member>?> getMembersStream({
    required String query,
    required int limit,
    required int offset,
    String? orderFieldID,
  }) {
    final membersRef = _firestore.collection('members');

    var memberQuery = membersRef
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: '$query\uf8ff')
        .limit(limit + offset);

    if (orderFieldID != null) {
      memberQuery = memberQuery.orderBy('scores.$orderFieldID.points', descending: true);
    } else {
      memberQuery = memberQuery.orderBy('name');
    }

    return memberQuery.snapshots().asyncMap((snapshot) async {
      List<Member> members = snapshot.docs.map((doc) {
        return Member.fromJson({
          'id': doc.id,
          'name': doc['name'],
          'scores': doc['scores'],
        });
      }).toList();

      for (var member in members) {
        member.totalScore = member.scores.fold(0, (sum, score) => sum + score.points);
      }

      members.sort((a, b) => b.totalScore.compareTo(a.totalScore));

      return members.skip(offset).take(limit).toList();
    });
  }

}