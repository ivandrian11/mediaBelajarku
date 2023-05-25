import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../model/order.dart';
import '../model/project.dart';
import '../model/promo.dart';
import '../model/course.dart';
import '../model/materials.dart';
import '../model/user.dart';

class ApiService {
  static const String baseUrl = 'https://skripsi-mb.my.id/api/v1';

  static Future<void> register(
    String username,
    String name,
    String email,
    String password,
  ) async {
    final body = {
      "username": username,
      "email": email,
      "password": password,
      "name": name
    };

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/user/register"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body),
      );
      returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  static Future<User> login(
    String email,
    String password,
  ) async {
    dynamic responseJson;
    final body = {"email": email, "password": password};

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/user/login"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body),
      );
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return User.fromJson(responseJson);
  }

  static Future<String> checkEmail(String email) async {
    dynamic responseJson;

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/user/check_email"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"email": email}),
      );
      responseJson = returnResponse(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  static Future<void> forgetPassword(
    String username,
    String password,
    String confirmPassword,
  ) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/user/forget_password/$username"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"password": password, "password2": confirmPassword}),
      );
      returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  static Future<void> changePassword(
    String username,
    String oldPassword,
    String password,
    String confirmPassword,
  ) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/user/change_password/$username"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "old_password": oldPassword,
          "password": password,
          "password2": confirmPassword
        }),
      );
      returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  static Future<String> updateStatusOrder(String orderId, String status) async {
    dynamic responseJson;
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/order/$orderId"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"status": status}),
      );
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return Order.fromJson(responseJson).status;
  }

  static Future<Order> createOrder(String username, String courseId, int total,
      [String promoId = ""]) async {
    dynamic responseJson, body;
    if (promoId.isEmpty) {
      body = {"user": username, "course": courseId, "total": total};
    } else {
      body = {
        "user": username,
        "course": courseId,
        "promo": promoId,
        "total": total
      };
    }
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/order"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body),
      );
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return Order.fromJson(responseJson);
  }

  static Future<void> sendProject(
    String username,
    String courseId,
    String url,
  ) async {
    final body = {"user": username, "course": courseId, "url": url};
    try {
      await http.post(
        Uri.parse("$baseUrl/project"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body),
      );
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  static Future<void> updateProject(
    String projectId,
    String url,
  ) async {
    try {
      await http.put(
        Uri.parse("$baseUrl/project/$projectId"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"url": url}),
      );
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  static Future<void> updateLimit(String id) async {
    try {
      await http.put(Uri.parse("$baseUrl/promo/$id"), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  static Future<Project?> getProject(String username, String courseId) async {
    dynamic responseJson;

    try {
      final response = await http.get(
        Uri.parse("$baseUrl/project/all?user=$username&course=$courseId"),
      );
      responseJson = returnResponse(response);

      if (responseJson.isEmpty) {
        return null;
      }

      return Project.fromJson(responseJson[0]);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  static Future<List<Project>> getAllProject(String username) async {
    List<Project> projects = [];
    dynamic responseJson;

    try {
      final response = await http.get(
        Uri.parse("$baseUrl/project/all?user=$username"),
      );
      responseJson = returnResponse(response);

      responseJson
          .forEach((project) => projects.add(Project.fromJson(project)));
      return projects;
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  static Future<List<Order>> getAllOrder(String username) async {
    List<Order> orders = [];
    dynamic responseJson;

    try {
      final response = await http.get(
        Uri.parse("$baseUrl/order/all?ordering=-created_at&user=$username"),
      );
      responseJson = returnResponse(response);
      responseJson.forEach((order) => orders.add(Order.fromJson(order)));
      return orders;
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  static Future<List<String>> getSuccessOrder(String username) async {
    List<String> ordersId = [];
    dynamic responseJson;

    try {
      final response = await http.get(
        Uri.parse(
            "$baseUrl/order/all?ordering=-created_at&status=success&user=$username"),
      );
      responseJson = returnResponse(response);
      responseJson
          .forEach((order) => ordersId.add(Order.fromJson(order).course));
      return ordersId;
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  static Future<List<Course>> getCourses() async {
    List<Course> courses = [];
    dynamic responseJson;

    try {
      final response = await http.get(
        Uri.parse("$baseUrl/course?ordering=-created_at"),
      );
      responseJson = returnResponse(response);
      responseJson.forEach((course) => courses.add(Course.fromJson(course)));
      return courses;
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  static Future<List<Materials>> getMaterials(String courseId) async {
    List<Materials> materials = [];
    dynamic responseJson;

    try {
      final response = await http.get(
        Uri.parse("$baseUrl/material?course=$courseId&ordering=id"),
      );
      responseJson = returnResponse(response);
      responseJson
          .forEach((material) => materials.add(Materials.fromJson(material)));
      return materials;
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  static Future<List<Promo>> getAllPromo() async {
    List<Promo> promos = [];
    dynamic responseJson;

    try {
      final response = await http.get(Uri.parse("$baseUrl/promo"));
      responseJson = returnResponse(response);
      responseJson.forEach((promo) => promos.add(Promo.fromJson(promo)));
      return promos;
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  @visibleForTesting
  static dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
        throw FetchDataException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occured while communication with server with status code : ${response.statusCode}');
    }
  }
}

class AppException implements Exception {
  final dynamic message;
  final dynamic prefix;

  AppException([this.message, this.prefix]);

  @override
  String toString() {
    return "$prefix$message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  // BadRequestException([message]) : super(message, "Invalid Request: ");
  BadRequestException([message]) : super(message, "");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised Request: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}
