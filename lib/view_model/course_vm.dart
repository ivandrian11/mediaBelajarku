import 'package:flutter/material.dart';
import '../data/api/api_service.dart';
import '../data/api/api_response.dart';
import '../data/helper/category_helper.dart';
import '../data/model/course.dart';

class CourseVM extends ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');
  ApiResponse get response => _apiResponse;

  List<Course> _result = [];
  List<Course> get result => _result;

  late List<Course> _filter;
  List<Course> get filter => _filter;

  late List<Course> _userCourses;
  List<Course> get userCourses => _userCourses;

  void searchCourse(String keyword) {
    if (keyword.isEmpty) {
      _result = [];
    } else {
      _result = [];
      List<Course> courses = [];
      courses.addAll(_apiResponse.data);
      courses.retainWhere(
          (e) => e.name.toLowerCase().contains(keyword.toLowerCase()));

      _result.addAll(courses);
    }
    notifyListeners();
  }

  Future<void> fetchAllCourse(String username) async {
    _apiResponse = ApiResponse.loading('Fetching data');
    notifyListeners();
    try {
      _userCourses = [];
      final courses = await ApiService.getCourses();
      courses.retainWhere((e) => e.available);

      final userCourses = await ApiService.getSuccessOrder(username);
      for (var courseId in userCourses) {
        _userCourses.add(courses.firstWhere((course) => course.id == courseId));
      }

      _filter = courses;
      _apiResponse = ApiResponse.completed(courses);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }

  void categoryClicked(CategoryHelper category) {
    CategoryHelper currentCategory = category;
    if (!currentCategory.isClicked) {
      currentCategory.isClicked = true;
      for (var category in categories) {
        if (category != currentCategory) {
          category.isClicked = false;
        }
      }
    }

    if (category.id == "C000") {
      _filter = [];
      _filter.addAll(_apiResponse.data);
    } else {
      _filter = [];
      _filter.addAll(_apiResponse.data);
      _filter.retainWhere((course) => course.category.id == category.id);
    }
    notifyListeners();
  }
}
