import 'package:flutter/material.dart';
import 'package:fubin/pages/my_order.dart';
import 'package:fubin/model/order_list_model.dart';
import 'package:provider/provider.dart';

class errorOrder extends StatefulWidget {
  @override
  _errorOrderState createState() => _errorOrderState();
}

class _errorOrderState extends State<errorOrder> {
  int i = 0;
  Map<String, dynamic> params = {
    "id": "10DCCFAE9F3E4E9D926ADED2A8953A50",
    "page": 0,
    "size": 3
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("故障订单"),
      ),
      body: ChangeNotifierProvider(
        builder: (context) => OrderListModel(isCheck: i, params: params),
        child: myOrder(isCheck: 0),
      ),
    );
  }
}
