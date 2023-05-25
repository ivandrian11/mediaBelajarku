import 'category.dart';
import 'mentor.dart';

class Course {
  Course({
    required this.id,
    required this.mentor,
    required this.category,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.available,
  });
  late final String id;
  late final Mentor mentor;
  late final Category category;
  late final String name;
  late final String description;
  late final String photoUrl;
  late final int price;
  late final String projectInstruction;
  late final DateTime createdAt;
  late final DateTime updatedAt;
  late final bool available;

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mentor = Mentor.fromJson(json['mentor']);
    category = Category.fromJson(json['category']);
    name = json['name'];
    description = json['description'];
    photoUrl = json['photoUrl'];
    price = json['price'];
    projectInstruction = json['project_instruction'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
    available = json['available'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['mentor'] = mentor.toJson();
    data['category'] = category.toJson();
    data['name'] = name;
    data['description'] = description;
    data['photoUrl'] = photoUrl;
    data['price'] = price;
    data['project_instruction'] = projectInstruction;
    data['created_at'] = createdAt.toIso8601String();
    data['updated_at'] = updatedAt.toIso8601String();
    data['available'] = available;
    return data;
  }
}
