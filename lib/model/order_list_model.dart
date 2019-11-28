import 'package:flutter/material.dart';
import 'package:fubin/config/api.dart';
import 'package:fubin/config/util.dart';
import 'package:fubin/bean/order.dart';

class OrderListModel with ChangeNotifier {
  List orderList;
  List get value => orderList;

  // 获取首页订单数据
  getOrder() {
    int isCheck = 0;
    // 需要借助工具把需要解析的对象生成对应的实体类，之后才能够借助工具进行解析
    Map<String, dynamic> params = {
      "id": "10DCCFAE9F3E4E9D926ADED2A8953A50",
      "page": 0,
      "size": 3
    };
    request(isCheck == 0 ? path['GetOrder'] : path['GetSuccessOrder'],
            params: params)
        .then((res) {
      Order order = new Order(res);
      if (order.code == 0) {
        orderList = order.datas;
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
