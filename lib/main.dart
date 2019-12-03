import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fubin/config/route/application.dart';
import 'package:fubin/config/route/routes.dart';
import 'package:fubin/pages/home_page.dart';
import 'package:fubin/utils/fluro/src/router.dart';

void main() {
  // 打开样式调试线
  debugPaintSizeEnabled = !true;

  //注册 fluro routes
  Router router = Router();
  Routes.configureRoutes(router);
  Application.router = router;

  runApp(HomePage());
}
