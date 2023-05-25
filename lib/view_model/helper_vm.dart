import 'package:flutter/material.dart';

class HelperVM extends ChangeNotifier {
  bool _isObscureOP = true;
  bool get isObscureOP => _isObscureOP;

  bool _isObscureP = true;
  bool get isObscureP => _isObscureP;

  bool _isObscureCP = true;
  bool get isObscureCP => _isObscureCP;

  bool _isExpanded = false;
  bool get isExpanded => _isExpanded;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  void stopLoading() {
    _isLoading = false;
    notifyListeners();
  }

  void toggleObscureOP() {
    _isObscureOP = !_isObscureOP;
    notifyListeners();
  }

  void toggleObscureP() {
    _isObscureP = !_isObscureP;
    notifyListeners();
  }

  void toggleObscureCP() {
    _isObscureCP = !_isObscureCP;
    notifyListeners();
  }

  void toggleExpanded() {
    _isExpanded = !_isExpanded;
    notifyListeners();
  }
}
