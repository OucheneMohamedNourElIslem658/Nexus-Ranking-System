class Field {
  final String name;

  Field({required this.name});

  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}

class Score {
  final int points;
  final Field field;

  Score({required this.points, required this.field});

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      points: json['points'] ?? 0,
      field: Field.fromJson(json['field'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'points': points,
      'field': field.toJson(),
    };
  }
}

class Member {
  final String id;
  final String name;
  final List<Score> scores;
  int totalScore;

  Member({
    required this.id,
    required this.name,
    required this.scores,
  }) : totalScore = scores.fold(0, (sum, score) => sum + score.points);

  factory Member.fromJson(Map<String, dynamic> json) {
    var scoreList = json['scores'] as List? ?? [];
    List<Score> scoresList = scoreList.map((i) => Score.fromJson(i)).toList();

    return Member(
      id: json['id'] ??'',
      name: json['name'] ?? '',
      scores: scoresList,
    );
  }
}