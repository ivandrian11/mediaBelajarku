import 'package:flutter/material.dart';
import 'package:media_belajarku/data/model/materials.dart';
import 'package:media_belajarku/data/model/project.dart';

import '../data/api/api_service.dart';
import '../data/api/api_response.dart';

class MaterialsVM extends ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');
  ApiResponse get response => _apiResponse;

  Project? _project;
  Project? get project => _project;

  Materials? _selected;
  Materials? get selected => _selected;

  void selectAMaterial(Materials material) {
    _selected = material;
    notifyListeners();
  }

  void nextMaterial() {
    List<Materials> materials = _apiResponse.data;
    _selected = materials[materials.indexOf(_selected!) + 1];
    notifyListeners();
  }

  Future<void> fetchMaterials(String courseId) async {
    _apiResponse = ApiResponse.loading('Fetching data');
    notifyListeners();
    try {
      final materials = await ApiService.getMaterials(courseId);
      _apiResponse = ApiResponse.completed(materials);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }

  Future<void> fetchDetails(String courseId, String username) async {
    _apiResponse = ApiResponse.loading('Fetching data');
    notifyListeners();
    try {
      _project = await ApiService.getProject(username, courseId);

      final materials = await ApiService.getMaterials(courseId);
      _apiResponse = ApiResponse.completed(materials);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }
}
