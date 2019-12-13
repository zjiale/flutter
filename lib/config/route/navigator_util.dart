import 'package:flutter/material.dart';
import 'package:fubin/store/bean/order_entity.dart';
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
      BuildContext context, int isCheck, String id, int page) {
    Application.router.navigateTo(
        context, Routes.myOrder + "?isCheck=$isCheck&id=$id&page=$page");
  }

  static Future goDetailInfo(
      BuildContext context, int isCheck, Datas detailInfo) {
    String detailInfo1 =
        FluroConvertUtils.fluroCnParamsEncode(detailInfo.toString());
    return Application.router.navigateTo(context,
        Routes.detailInfo + "?isCheck=$isCheck&detailInfo=$detailInfo1");
  }

  static void goBackHomePage(BuildContext context, result) {
    Navigator.of(context).pop(result);
  }
}
