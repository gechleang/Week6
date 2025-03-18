class CourseScore {
  final String studentName;
  final double studentScore;

  const CourseScore({
    required this.studentName, 
    required this.studentScore, required double value
  });
}

class Course {
  final String id;
  final String name;
  final String description;
  final List<CourseScore> scores;

  Course({
    required this.id,
    required this.name,
    required this.description,
    List<CourseScore>? initialScores, required List<CourseScore> scores,
  }) : scores = initialScores ?? [];

  void addScore(CourseScore score) {
    scores.add(score);
  }

  bool get hasScore => scores.isNotEmpty;

  double get average {
    if (scores.isNotEmpty) {
      double total = scores.fold(0, (prev, score) => prev + score.studentScore);
      return total / scores.length;
    }
    return 0;
  }

  Course copyWith({
    String? id,
    String? name,
    String? description,
    List<CourseScore>? scores,
  }) {
    return Course(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      initialScores: scores ?? this.scores, scores: [],
    );
  }
}