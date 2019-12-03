import 'package:flutter/material.dart';
import 'package:fubin/model/login_info_model.dart';
import 'package:fubin/pages/login.dart';
import 'package:fubin/base/bottom_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This Widget is the main application widget.
class HomePage extends StatelessWidget {
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
