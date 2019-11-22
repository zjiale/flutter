import 'package:flutter/material.dart';
import 'package:fubin/pages/my_order.dart';

class errorOrder extends StatefulWidget {
  @override
  _errorOrderState createState() => _errorOrderState();
}

class _errorOrderState extends State<errorOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("故障订单"),
      ),
      body: myOrder(isCheck: 0),
    );
  }
}
