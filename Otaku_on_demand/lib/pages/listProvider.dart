import 'package:flutter/material.dart';

class ListProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _loadedItems = [];

  List<Map<String, dynamic>> get loadedItems => _loadedItems;

  void addLoadedItems(List<Map<String, dynamic>> items) {
    _loadedItems.addAll(items);
    notifyListeners();
  }
}
