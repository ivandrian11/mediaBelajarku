class Materials {
  Materials({
    required this.id,
    required this.course,
    required this.title,
    required this.body,
  });
  late final String id;
  late final String course;
  late final String title;
  late final String body;

  Materials.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    course = json['course'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['course'] = course;
    data['title'] = title;
    data['body'] = body;
    return data;
  }
}
