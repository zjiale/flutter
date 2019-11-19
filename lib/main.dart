import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'base/bottom_navigation.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(MyApp());
}

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _Hometitle = '富斌易购';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _Hometitle,
      home: BottomNavigation(),
    );
  }
}
