import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:fubin/base/bottom_navigation.dart';
import 'package:fubin/model/is_check_model.dart';
import 'package:fubin/pages/detail_info.dart';
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
  return ChangeNotifierProvider.value(
      value: IsCheckModel(), child: new BottomNavigation());
});

// 已完成订单列表
var successOrderHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String isCheck = params["isCheck"]?.first;
  String search = params["search"]?.first;

  return MultiProvider(
    providers: [
      ChangeNotifierProvider.value(
        value: OrderListModel(
          isCheck: FluroConvertUtils.string2int(isCheck),
          params: convert.jsonDecode(search),
        ),
      ),
      ChangeNotifierProvider.value(
        value: IsCheckModel(),
      )
    ],
    child: Scaffold(
      appBar: AppBar(title: new Text('我的订单')),
      body: myOrder(),
    ),
  );
});

var detailInfoHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String isCheck = params["isCheck"]?.first;
  String oid = params["oid"]?.first;
  String orderList = params["orderList"]?.first;

  print(convert.jsonDecode(orderList));

  return new Scaffold(
    appBar: AppBar(title: Text('订单详情')),
    body: detailInfo(
        isCheck: FluroConvertUtils.string2int(isCheck),
        oid: oid,
        orderList: convert.jsonDecode(orderList)),
  );
});
