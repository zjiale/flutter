import 'package:flutter/material.dart';

class IsCheckModel with ChangeNotifier {
  int _isCheck = 0;
  int get value => _isCheck;

  void change(int index) {
    _isCheck = index;
    notifyListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
