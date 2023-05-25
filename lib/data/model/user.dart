class User {
  User({
    required this.data,
    required this.token,
  });
  late final Data data;
  late final String token;

  User.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json['data']);
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final temp = <String, dynamic>{};
    temp['data'] = data.toJson();
    temp['token'] = token;
    return temp;
  }
}

class Data {
  Data({
    required this.message,
    required this.username,
    required this.email,
    required this.name,
    required this.photoUrl,
  });
  late final String message;
  late final String username;
  late final String email;
  late final String name;
  late final String photoUrl;

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    username = json['username'];
    email = json['email'];
    name = json['name'];
    photoUrl = json['photoUrl'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    data['username'] = username;
    data['email'] = email;
    data['name'] = name;
    data['photoUrl'] = photoUrl;
    return data;
  }
}
