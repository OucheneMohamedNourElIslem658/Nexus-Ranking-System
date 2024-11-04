class Field {
  final String name;
  final String? id;
  final int membersCount;

  Field({
    this.id, 
    required this.name, 
    this.membersCount = 0
  });

  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      membersCount: json['membersCount'] ?? 0
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'membersCount': membersCount
    };
  }
}

class Score {
  final int points;
  final String field;
  Field? fieldInfo;

  Score({
    required this.points, 
    required this.field,
    this.fieldInfo
  });

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      points: json['points'] ?? 0,
      field: json['field'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'points': points,
      'field': field,
    };
  }
}

class Member {
  final String uid;
  final String name;
  final String email;
  final String? imageURL;
  final List<Score> scores;
  int totalScore;

  Member({
    required this.uid,
    required this.name,
    this.imageURL,
    required this.scores,
    this.email = "undefined email",
    this.totalScore = 0
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    var scoreList = json['scores'] as List? ?? [];
    List<Score> scoresList = scoreList.map((i) => Score.fromJson(i)).toList();

    return Member(
      uid: json['uid'] ??'',
      name: json['name'] ?? 'undefined name',
      imageURL: json['imageURL'],
      email: json['email'],
      scores: scoresList,
    );
  }
}