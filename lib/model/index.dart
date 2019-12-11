import 'dart:convert' as convert;
import 'package:flutter/material.dart' show BuildContext;
import 'package:fubin/config/cache.dart';
import 'package:provider/provider.dart'
    show ChangeNotifierProvider, MultiProvider, Consumer, Provider;
import 'package:fubin/model/order_list_model.dart' show OrderListModel;
import 'package:fubin/model/is_check_model.dart' show IsCheckModel;
import 'package:fubin/model/login_info_model.dart' show LoginInfoModel;
export 'package:provider/provider.dart';

class Store {
  static BuildContext context;
  static BuildContext widgetCtx;
  static const String _StorageKey = 'PRES_USER_INFO_KEY';

  //  我们将会在main.dart中runAPP实例化init
  static init({context, child}) {
    var userInfo = SpUtil.preferences.get(_StorageKey);
    int isCheck = 0;
    int page = 0;

    if (userInfo != null) {
      String id = convert.jsonDecode(userInfo)["id"];

      return MultiProvider(
        providers: [
          ChangeNotifierProvider(builder: (_) => IsCheckModel()),
          ChangeNotifierProvider(
            builder: (_) =>
                OrderListModel(isCheck: isCheck, id: id, page: page),
          ),
          ChangeNotifierProvider(
            builder: (_) => LoginInfoModel(),
          )
        ],
        child: child,
      );
    } else {
      return ChangeNotifierProvider.value(
        value: LoginInfoModel(),
        child: child,
      );
    }
  }

  //  通过Provider.value<T>(context)获取状态数据
  static T value<T>(context) {
    return Provider.of(context);
  }

  //  通过Consumer获取状态数据
  static Consumer connect<T>({builder, child}) {
    return Consumer<T>(builder: builder, child: child);
  }
}
