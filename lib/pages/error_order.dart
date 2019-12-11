import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:fubin/config/cache.dart';
import 'package:fubin/model/index.dart' show Store;
import 'package:fubin/model/is_check_model.dart';
import 'package:fubin/pages/my_order.dart';
import 'package:fubin/model/order_list_model.dart';

class ErrorOrder extends StatefulWidget {
  @override
  _ErrorOrderState createState() => _ErrorOrderState();
}

class _ErrorOrderState extends State<ErrorOrder>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;
  // final String _StorageKey = 'PRES_USER_INFO_KEY';
  // int page = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // int isCheck = Store.value<IsCheckModel>(context).value;
    // String id = convert.jsonDecode(SpUtil.preferences.get(_StorageKey))["id"];
    Store.value<OrderListModel>(context).getOrder();

    return Scaffold(
        appBar: AppBar(
          title: new Text("故障订单"),
        ),
        body: MyOrder());
  }
}
