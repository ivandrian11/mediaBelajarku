import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:media_belajarku/data/helper/helper.dart';

import '../data/api/api_service.dart';
import '../common/navigation.dart';
import '../data/api/api_response.dart';
import '../data/model/user.dart';

class UserVM extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ApiResponse _apiResponse = ApiResponse.initial('Empty data');
  ApiResponse get response => _apiResponse;

  void changeUser(String user) {
    if (user.isEmpty) {
      _apiResponse = ApiResponse.initial('Empty data');
    } else {
      _apiResponse = ApiResponse.completed(User.fromJson(jsonDecode(user)));
    }
  }

  Future<void> registerUser(
    String username,
    String name,
    String email,
    String password,
  ) async {
    _isLoading = true;
    notifyListeners();
    try {
      await ApiService.register(username, name, email, password);
      Navigation.off('/login');
      showSuccessMessage("User registered successfully!");
    } catch (e) {
      showErrorMessage(e.toString());
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> loginUser(
    String email,
    String password,
    Function callback,
  ) async {
    _isLoading = true;
    notifyListeners();
    try {
      final user = await ApiService.login(email, password);
      callback(user);
      _apiResponse = ApiResponse.completed(user);
      Navigation.off('/main');
    } catch (e) {
      showErrorMessage(e.toString());
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> checkEmailUser(String email) async {
    _isLoading = true;
    notifyListeners();
    try {
      final username = await ApiService.checkEmail(email);
      _apiResponse = ApiResponse.completed(username);
    } catch (e) {
      showErrorMessage(e.toString());
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> forgetPasswordUser(
    String username,
    String password,
    String confirmPassword,
  ) async {
    _isLoading = true;
    notifyListeners();
    try {
      await ApiService.forgetPassword(username, password, confirmPassword);
      Navigation.offAll('/login');
      showSuccessMessage("Password changed successfully!");
    } catch (e) {
      showErrorMessage(e.toString());
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> changePasswordUser(
    String username,
    String oldPassword,
    String password,
    String confirmPassword,
  ) async {
    _isLoading = true;
    notifyListeners();
    try {
      await ApiService.changePassword(
          username, oldPassword, password, confirmPassword);
      Navigation.offAll('/main');
      showSuccessMessage("Password changed successfully!");
    } catch (e) {
      showErrorMessage(e.toString());
    }

    _isLoading = false;
    notifyListeners();
  }
}
