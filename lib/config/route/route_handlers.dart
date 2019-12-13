import 'package:flutter/material.dart';
import 'package:fubin/base/bottom_navigation.dart';

import 'package:fubin/store/index.dart'
    show Store, ChangeMsgModel, OrderListModel, IsCheckModel;
import 'package:fubin/pages/detail_info.dart';
import 'package:fubin/pages/login.dart';
import 'package:fubin/pages/my_order.dart';
import 'package:fubin/pages/home_page.dart';
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
  return new Login();
});

// 首页
var bottomNavigationHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return Store.init(
      context: context,
      child: Builder(
        builder: (context) {
          Store.widgetCtx = context;
          return BottomNavigation();
        },
      ));
});

// 已完成订单列表
var successOrderHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String isCheck = params["isCheck"]?.first;
  String id = params["id"]?.first;
  String page = params["page"]?.first;

  return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            builder: (_) => OrderListModel(
                isCheck: FluroConvertUtils.string2int(isCheck),
                id: id,
                page: FluroConvertUtils.string2int(page))),
        ChangeNotifierProvider(
          builder: (_) => IsCheckModel(),
        )
      ],
      child: Scaffold(
        appBar: AppBar(title: new Text('我的订单')),
        body: MyOrder(),
      )
      // ChangeNotifierProvider.value(
      //     value: OrderListModel(
      //         isCheck: FluroConvertUtils.string2int(isCheck),
      //         id: id,
      //         page: FluroConvertUtils.string2int(page)),
      //     child: Scaffold(
      //       appBar: AppBar(title: new Text('我的订单')),
      //       body: MyOrder(),
      //     ));

      );
});

var detailInfoHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String isCheck = params["isCheck"]?.first;
  String orderInfo = params["detailInfo"]?.first;

  return new Scaffold(
    appBar: AppBar(title: Text('订单详情')),
    body: ChangeNotifierProvider(
      builder: (_) => ChangeMsgModel(),
      child: DetailInfo(
          isCheck: FluroConvertUtils.string2int(isCheck),
          orderInfo: FluroConvertUtils.string2map(orderInfo)),
    ),
  );
});
