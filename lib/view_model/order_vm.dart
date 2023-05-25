import 'package:flutter/material.dart';
import 'package:media_belajarku/data/helper/helper.dart';
import 'package:media_belajarku/data/model/order.dart';
import '../common/navigation.dart';
import '../data/api/api_service.dart';
import '../data/api/api_response.dart';

class OrderVM extends ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');
  ApiResponse get response => _apiResponse;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> processOrder(String username, String courseId, int total,
      [String promoId = ""]) async {
    Order order;
    _isLoading = true;
    notifyListeners();
    try {
      if (promoId.isEmpty) {
        order = await ApiService.createOrder(username, courseId, total);
      } else {
        order =
            await ApiService.createOrder(username, courseId, total, promoId);
      }
      if (total > 0) {
        Navigation.offWithData("/order", order);
      } else {
        Navigation.offAllWithData('/status_order', order.status);
      }
    } catch (e) {
      showErrorMessage(e.toString());
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchAllOrder(String username) async {
    _apiResponse = ApiResponse.loading('Fetching data');
    notifyListeners();
    try {
      final orders = await ApiService.getAllOrder(username);
      _apiResponse = ApiResponse.completed(orders);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }
}
