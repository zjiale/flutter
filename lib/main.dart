import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fubin/model/login_info_model.dart';
import 'package:fubin/pages/login.dart';
import 'base/bottom_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  debugPaintSizeEnabled = !true;
  runApp(MyApp());
}

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _Hometitle = '富斌易购';
  var userInfo;

  @override
  Widget build(BuildContext context) {
    Future<String> get() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var user = prefs.getString('userInfo');
      return user;
    }

    Future<String> getUserInfo = get().then((res) {
      userInfo = res;
    });

    return MaterialApp(
      title: _Hometitle,
      home: userInfo != null
          ? BottomNavigation()
          : ChangeNotifierProvider(
              builder: (context) => LoginInfoModel(),
              child: login(),
            ),
      // home: BottomNavigation(),
    );
  }
}
