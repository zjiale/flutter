import 'package:flutter/material.dart';
import 'package:fubin/config/cache.dart';
import 'package:fubin/model/index.dart' show Store;
import 'package:fubin/pages/login.dart';
import 'package:fubin/base/bottom_navigation.dart';

/// This Widget is the main application widget.
class HomePage extends StatelessWidget {
  static const String _HomeTitle = '富斌易购';
  static const String _StorageKey = 'PRES_USER_INFO_KEY';

  @override
  Widget build(BuildContext context) {
    var userInfo = SpUtil.preferences.get(_StorageKey);
    Widget entrance = userInfo != null ? BottomNavigation() : Login();

    return Store.init(
        context: context,
        child: MaterialApp(
          title: _HomeTitle,
          home: Builder(
            builder: (context) {
              Store.widgetCtx = context;
              return entrance;
            },
          ),
        ));

    // return MaterialApp(
    //   title: _HomeTitle,
    //   home: userInfo != null
    //       ? ChangeNotifierProvider.value(
    //             value: IsCheckModel(),
    //             child: BottomNavigation(),
    //           )
    //       : ChangeNotifierProvider.value(
    //           value: LoginInfoModel(),
    //           child: Login(),
    //         ),
    // );
  }
}
