import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:fubin/bean/order_entity.dart';
import 'package:fubin/config/route/application.dart';
import 'package:fubin/config/route/routes.dart';
import 'package:fubin/utils/fluro_convert_util.dart';

class NavigatorUtil {
  static void logout(BuildContext context) {
    Application.router.navigateTo(context, Routes.homePage, replace: true);
  }

  static void goBottomNavigation(BuildContext context) {
    Application.router
        .navigateTo(context, Routes.bottomNavigation, replace: true);
  }

  static void goSuccessOrder(
      BuildContext context, int isCheck, Map<String, dynamic> search) {
    String search1 = convert.jsonEncode(search);
    Application.router.navigateTo(
        context, Routes.myOrder + "?isCheck=$isCheck&search=$search1");
  }

  static Future goDetailInfo(
      BuildContext context, int isCheck, Datas detailInfo) {
    String detailInfo1 =
        FluroConvertUtils.fluroCnParamsEncode(detailInfo.toString());
    return Application.router.navigateTo(context,
        Routes.detailInfo + "?isCheck=$isCheck&detailInfo=$detailInfo1");
  }

  static void goBackHomePage(BuildContext context, result) {
    Navigator.pop(context, result);
  }
}
