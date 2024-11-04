import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nexus_ranking_system/models/member.dart';

class RankRepo {
  static final _firestore = FirebaseFirestore.instance;

  static Stream<List<Member>> getMembersStream({
    String? query,
    int? limit,
    String? orderFieldID,
  }) {
    final membersRef = _firestore.collection('members');
    var memberQuery = membersRef as Query<Map<String, dynamic>>;

    if (query != null && query.isNotEmpty) {
      memberQuery = memberQuery
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThanOrEqualTo: '$query\uf8ff');
    }

    if (limit != null) {
      memberQuery = memberQuery.limit(limit);
    }

    return memberQuery.snapshots().asyncMap((snapshot) async {
      List<Member> members = snapshot.docs.map((doc) {
        return Member.fromJson({
          'uid': doc.id,
          'email': doc['email'],
          'name': doc['name'],
          'scores': doc['scores'],
          'imageURL': doc['imageURL'],
        });
      }).toList();

      for (var member in members) {
        if (orderFieldID != null) {
          var fieldScore = member.scores.firstWhere(
            (score) => score.field == orderFieldID,
            orElse: () => Score(points: 0, field: orderFieldID),
          );
          member.totalScore = fieldScore.points;
        } else {
          member.totalScore = member.scores.fold(0, (sum, score) => sum + score.points);
        }
      }

      members.sort((a, b) => b.totalScore.compareTo(a.totalScore));

      if (limit != null) {
        while (members.length < limit) {
          members.add(Member(
            uid: '',
            name: '...',
            scores: [],
            imageURL: '',
          ));
        }
      }
      return members;
    });
  }

  static Future<Member?> getCurrentUserScores(String uid) async {
    final memberDoc = await _firestore.collection('members').doc(uid).get();
    if (!memberDoc.exists) return null;

    final memberData = memberDoc.data();
    final scoresList = memberData?['scores'] as List<dynamic>? ?? [];

    List<Score> scores = await Future.wait(
      scoresList.map((scoreJson) async {
        final score = Score.fromJson(scoreJson);

        if (score.field.isNotEmpty) {
          final fieldDoc = await _firestore.collection('fields').doc(score.field).get();
          if (fieldDoc.exists) {
            score.fieldInfo = Field.fromJson(fieldDoc.data()!);
          }
        }
        return score;
      }).toList(),
    );

    int totalScore = scores.fold(0, (sum, score) => sum + score.points);

    return Member(
      uid: uid,
      name: memberData?['name'] ?? 'Unknown',
      email: memberData?['email'] ?? 'undefined email',
      imageURL: memberData?['imageURL'],
      scores: scores,
      totalScore: totalScore,
    );
  }

  static Stream<List<Field>> getAllFieldsStream() {
    return _firestore.collection('fields').snapshots().asyncMap((snapshot) async {
      List<Future<Field>> futures = [];
      for (var doc in snapshot.docs) {
        String fieldName = doc['name'];
        futures.add(Future(() async {
          int membersCount = await _fetchMembersCount(fieldName);
          return Field.fromJson({
            'id': doc['id'],
            'name': fieldName,
            'membersCount': membersCount,
          });
        }));
      }
      List<Field> fields = await Future.wait(futures);
      return fields;
    });
  }

  static Future<int> _fetchMembersCount(String fieldName) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('members')
        .where('scores.field', isEqualTo: fieldName)
        .get();
    return querySnapshot.docs.length;
  }
}
