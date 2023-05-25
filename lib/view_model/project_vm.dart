import 'package:flutter/material.dart';
import 'package:media_belajarku/data/helper/helper.dart';
import 'package:media_belajarku/data/model/project.dart';
import '../data/api/api_service.dart';
import '../data/api/api_response.dart';

class ProjectVM extends ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');
  ApiResponse get response => _apiResponse;

  List<Project> _projects = [];
  List<Project> get projects => _projects;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> sendProjectUser(
    String username,
    String courseId,
    String url,
  ) async {
    try {
      await ApiService.sendProject(username, courseId, url);
    } catch (e) {
      showErrorMessage(e.toString());
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateProjectUser(
    String projectId,
    String url,
  ) async {
    _isLoading = true;
    notifyListeners();
    try {
      await ApiService.updateProject(projectId, url);
    } catch (e) {
      showErrorMessage(e.toString());
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getProjectUser(String username, String courseId) async {
    _apiResponse = ApiResponse.loading('Fetching data');
    notifyListeners();
    try {
      final project = await ApiService.getProject(username, courseId);
      _apiResponse = ApiResponse.completed(project);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }

  Future<void> fetchAllProject(String username) async {
    _isLoading = true;

    notifyListeners();
    try {
      final projects = await ApiService.getAllProject(username);
      _projects = projects;
    } catch (e) {
      showErrorMessage(e.toString());
    }
    _isLoading = false;
    notifyListeners();
  }
}
