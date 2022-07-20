import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  Color mainColor = Colors.redAccent;

  void changeThemeColor(Color color) {
    mainColor = color;
    notifyListeners();
  }
}
