import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:fubin/config/cache.dart';
import 'package:fubin/model/is_check_model.dart';
import 'package:fubin/pages/my_order.dart';
import 'package:fubin/model/order_list_model.dart';
import 'package:provider/provider.dart';

class ErrorOrder extends StatefulWidget {
  @override
  _ErrorOrderState createState() => _ErrorOrderState();
}

class _ErrorOrderState extends State<ErrorOrder>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;
  final String key = 'PRES_USER_INFO_KEY';

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final int isCheck = Provider.of<IsCheckModel>(context).value;
    String id = convert.jsonDecode(SpUtil.preferences.get(key))["id"];

    return Scaffold(
        appBar: AppBar(
          title: new Text("故障订单"),
        ),
        body: ChangeNotifierProvider.value(
          value: OrderListModel(isCheck: isCheck, id: id, page: 0),
          child: MyOrder(),
        ));
  }
}
