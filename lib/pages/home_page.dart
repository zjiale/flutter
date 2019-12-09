import 'package:flutter/material.dart';
import 'package:fubin/model/is_check_model.dart';
import 'package:fubin/model/login_info_model.dart';
import 'package:fubin/pages/login.dart';
import 'package:fubin/base/bottom_navigation.dart';
import 'package:provider/provider.dart';

/// This Widget is the main application widget.
class HomePage extends StatelessWidget {
  static const String _Hometitle = '富斌易购';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _Hometitle,
      home: ChangeNotifierProvider(
        builder: (context) => LoginInfoModel(),
        child: MainComponent(),
      ),
    );
  }
}

class MainComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userInfo = Provider.of<LoginInfoModel>(context).value;
    return MultiProvider(providers: [
      ChangeNotifierProvider.value(value: LoginInfoModel()),
      ChangeNotifierProvider.value(
        value: IsCheckModel(),
      )
    ], child: userInfo != null ? BottomNavigation() : Login());
  }
}
