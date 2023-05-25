class Project {
  Project({
    required this.id,
    required this.course,
    required this.user,
    required this.url,
    required this.feedback,
    required this.score,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String id;
  late final String course;
  late final String user;
  late final String url;
  late final String feedback;
  late final int score;
  late final DateTime createdAt;
  late final DateTime updatedAt;

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    course = json['course'];
    user = json['user'];
    url = json['url'] ?? "";
    feedback = json['feedback'] ?? "";
    score = json['score'] ?? 0;
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['course'] = course;
    data['user'] = user;
    data['url'] = url;
    data['feedback'] = feedback;
    data['score'] = score;
    data['created_at'] = createdAt.toIso8601String();
    data['updated_at'] = updatedAt.toIso8601String();
    return data;
  }
}
