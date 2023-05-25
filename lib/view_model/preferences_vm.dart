import 'dart:convert';

import 'package:flutter/material.dart';
import '../data/model/user.dart';
import '../data/helper/preferences_helper.dart';

class PreferencesVM extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesVM({required this.preferencesHelper}) {
    getFirstTimePreferences();
    getLoggedPreferences();
  }

  bool _isFirstTime = false;
  bool get isFirstTime => _isFirstTime;

  void getFirstTimePreferences() async {
    _isFirstTime = await preferencesHelper.isFirstTime;
    notifyListeners();
  }

  void changeFirstTime(bool value) {
    preferencesHelper.setFirstTime(value);
    getFirstTimePreferences();
  }

  String _isLogged = "";
  String get isLogged => _isLogged;

  void getLoggedPreferences() async {
    _isLogged = await preferencesHelper.isLogged;
    notifyListeners();
  }

  void setLogged(User user) {
    preferencesHelper.setLogged(jsonEncode(user.toJson()));
    getLoggedPreferences();
  }

  void removeLogged() {
    preferencesHelper.setLogged("");
    getLoggedPreferences();
  }
}
