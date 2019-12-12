import 'dart:convert' as convert;
import 'package:flutter/material.dart' show BuildContext;
import 'package:fubin/config/cache.dart';
import 'package:provider/provider.dart'
    show
        ChangeNotifierProvider,
        MultiProvider,
        Consumer,
        Consumer2,
        Consumer3,
        Provider;
import 'model/index.dart' show OrderListModel, IsCheckModel, LoginInfoModel;

export 'model/index.dart';
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
          /* 
            provider得value方法不会释放model得资源，而另一种方式在widget树删除之后
            就会调用dispose方法把资源释放数据就会清空。这里OrderListModel只能使用
            builder方法，在打开我的订单得时候需要释放数据重置才行。
           */
          ChangeNotifierProvider.value(value: IsCheckModel()),
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
      return ChangeNotifierProvider(
        builder: (_) => LoginInfoModel(),
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

  static Consumer2 connect2<A, B>({builder, child}) {
    return Consumer2<A, B>(builder: builder, child: child);
  }

  static Consumer3 connect3<A, B, C>({builder, child}) {
    return Consumer3<A, B, C>(builder: builder, child: child);
  }
}
