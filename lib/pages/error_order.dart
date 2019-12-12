import 'package:flutter/material.dart';
import 'package:fubin/store/index.dart' show Store, OrderListModel;
import 'package:fubin/pages/my_order.dart';

class ErrorOrder extends StatefulWidget {
  @override
  _ErrorOrderState createState() => _ErrorOrderState();
}

class _ErrorOrderState extends State<ErrorOrder>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Store.value<OrderListModel>(context).getOrder();

    return Scaffold(
        appBar: AppBar(
          title: new Text("故障订单"),
        ),
        body: MyOrder());
  }
}
