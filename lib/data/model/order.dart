class Order {
  Order({
    required this.id,
    required this.user,
    required this.course,
    required this.status,
    required this.total,
    required this.url,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String id;
  late final String user;
  late final String course;
  late final String status;
  late final int total;
  late final String url;
  late final DateTime createdAt;
  late final DateTime updatedAt;

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    course = json['course'];
    status = json['status'];
    total = json['total'];
    url = json['url'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['user'] = user;
    data['course'] = course;
    data['status'] = status;
    data['total'] = total;
    data['url'] = url;
    data['created_at'] = createdAt.toIso8601String();
    data['updated_at'] = updatedAt.toIso8601String();
    return data;
  }
}
