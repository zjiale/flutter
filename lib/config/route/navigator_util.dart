import 'package:flutter/material.dart';
import 'package:fubin/config/route/application.dart';
import 'package:fubin/config/route/routes.dart';

class NavigatorUtil {
  static void goHomePage(BuildContext context) {
    Application.router.navigateTo(context, Routes.homePage, replace: true);
  }

  static void logout(BuildContext context) {
    Application.router.navigateTo(context, Routes.login, replace: true);
  }
}
