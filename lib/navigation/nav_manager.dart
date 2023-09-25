import 'package:flutter/material.dart';

class CNavManager extends ChangeNotifier {
  String? _selectedRoute;
  String? get selectedRoute => _selectedRoute;

  void notifyRoute(String? route) {
    if (route == null) {
      return;
    }
    _selectedRoute = route;
    notifyListeners();
  }
}
