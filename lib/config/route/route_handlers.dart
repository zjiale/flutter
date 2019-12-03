import 'package:flutter/material.dart';
import 'package:fubin/base/bottom_navigation.dart';
import 'package:fubin/pages/error_order.dart';
import 'package:fubin/pages/login.dart';
import 'package:fubin/utils/fluro/src/common.dart';

// 登录
var loginHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new login();
});

// 首页
var homeHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new BottomNavigation();
});
