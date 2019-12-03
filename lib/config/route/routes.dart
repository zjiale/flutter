import 'package:flutter/material.dart';
import 'package:fubin/utils/fluro/fluro.dart';
import 'package:fubin/config/route/route_handlers.dart';

class Routes {
  // 可以设置启动页
  static String root = "/";
  static String homePage = "/bottom_navigation";
  static String login = "/login";
  // static String errorOrder = "/error_order";
  // static String personal = "/personal";
  static String myOrder = "/my_order";
  static String detailInfo = "/detail_info";

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });

    /// 第一个参数是路由地址，第二个参数是页面跳转和传参，第三个参数是默认的转场动画
    router.define(homePage, handler: homeHandler);
    router.define(login, handler: loginHandler);
  }
}
