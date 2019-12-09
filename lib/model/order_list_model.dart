import 'package:flutter/material.dart';
import 'package:fubin/config/api.dart';
import 'package:fubin/config/util.dart';
import 'package:fubin/bean/order_entity.dart';

class OrderListModel with ChangeNotifier {
  List orderList;
  List get value => orderList;

  final int isCheck;
  final int page;
  final String id;
  OrderListModel(
      {Key key,
      @required this.isCheck,
      @required this.id,
      @required this.page});

  // 获取首页订单数据
  getOrder() {
    Map<String, dynamic> params = {"page": page, "size": 3, "id": id};
    // 需要借助工具把需要解析的对象生成对应的实体类，之后才能够借助工具进行解析
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
