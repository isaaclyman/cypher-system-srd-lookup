import 'package:flutter/material.dart';

class CNavManager extends ChangeNotifier {
  String? _selectedRoute;
  String? get selectedRoute => _selectedRoute;

  void changeRoute(String route) {
    _selectedRoute = route;
    notifyListeners();
  }
}
