import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fubin/pages/my_order.dart';
import 'package:fubin/config/api.dart';
import 'package:fubin/config/util.dart';

class errorOrder extends StatefulWidget {
  @override
  _errorOrderState createState() => _errorOrderState();
}

class _errorOrderState extends State<errorOrder> {
  @override
  void initState() {
    request(path['IndexGoodsType']).then((val) {
      Map<String, dynamic> user = json.decode(val);
      print(user);
    });
    super.initState();
  }

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
