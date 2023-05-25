import 'package:flutter/material.dart';
import 'package:media_belajarku/data/helper/helper.dart';
import 'package:media_belajarku/data/model/promo.dart';
import '../data/api/api_service.dart';
import '../data/api/api_response.dart';

class PromoVM extends ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');
  ApiResponse get response => _apiResponse;

  Promo? _selected;
  Promo? get selected => _selected;

  void selectAPromo(Promo? promo) {
    _selected = promo;
    notifyListeners();
  }

  Future<void> fetchAllPromo() async {
    _apiResponse = ApiResponse.loading('Fetching data');
    notifyListeners();
    try {
      final promos = await ApiService.getAllPromo();
      _apiResponse = ApiResponse.completed(promos);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }

  Future<void> updateLimitPromo(String id) async {
    // _isLoading = true;
    // notifyListeners();
    try {
      await ApiService.updateLimit(id);
    } catch (e) {
      showErrorMessage(e.toString());
    }
    // _isLoading = false;
    // notifyListeners();
  }
}
