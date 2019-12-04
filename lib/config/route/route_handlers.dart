import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:fubin/base/bottom_navigation.dart';
import 'package:fubin/pages/login.dart';
import 'package:fubin/pages/my_order.dart';
import 'package:fubin/pages/home_page.dart';
import 'package:fubin/model/order_list_model.dart';
import 'package:fubin/utils/fluro/src/common.dart';
import 'package:fubin/utils/fluro_convert_util.dart';
import 'package:provider/provider.dart';

var homeHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new HomePage();
});

// 登录
var loginHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new login();
});

// 首页
var bottomNavigationHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new BottomNavigation();
});

// 已完成订单列表
var successOrderHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String isCheck = params["isCheck"]?.first;
  String search = params["search"]?.first;

  return ChangeNotifierProvider(
    builder: (context) => OrderListModel(
        isCheck: FluroConvertUtils.string2int(isCheck),
        params: convert.jsonDecode(search)),
    child: myOrder(),
  );
});
