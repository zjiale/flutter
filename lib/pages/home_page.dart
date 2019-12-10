import 'package:flutter/material.dart';
import 'package:fubin/config/cache.dart';
import 'package:fubin/model/is_check_model.dart';
import 'package:fubin/model/login_info_model.dart';
import 'package:fubin/pages/login.dart';
import 'package:fubin/base/bottom_navigation.dart';
import 'package:provider/provider.dart';

/// This Widget is the main application widget.
class HomePage extends StatelessWidget {
  static const String _HomeTitle = '富斌易购';
  static const String _StorageKey = 'PRES_USER_INFO_KEY';

  @override
  Widget build(BuildContext context) {
    var userInfo = SpUtil.preferences.get(_StorageKey);
    return MaterialApp(
      title: _HomeTitle,
      home: MultiProvider(providers: [
        ChangeNotifierProvider.value(value: LoginInfoModel()),
        ChangeNotifierProvider.value(
          value: IsCheckModel(),
        )
      ], child: userInfo != null ? BottomNavigation() : Login()),
    );
  }
}
