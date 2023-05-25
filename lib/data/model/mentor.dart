class Mentor {
  Mentor({
    required this.id,
    required this.name,
    required this.job,
    required this.photoUrl,
  });
  late final String id;
  late final String name;
  late final String job;
  late final String photoUrl;

  Mentor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    job = json['job'];
    photoUrl = json['photoUrl'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['job'] = job;
    data['photoUrl'] = photoUrl;
    return data;
  }
}
