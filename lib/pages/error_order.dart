import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:fubin/model/is_check_model.dart';
import 'package:fubin/pages/my_order.dart';
import 'package:fubin/model/order_list_model.dart';
import 'package:provider/provider.dart';
import 'package:fubin/model/login_info_model.dart';

class ErrorOrder extends StatefulWidget {
  @override
  _ErrorOrderState createState() => _ErrorOrderState();
}

class _ErrorOrderState extends State<ErrorOrder>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;
  var userInfo;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final int isCheck = Provider.of<IsCheckModel>(context).value;
    print(isCheck);
    final String id =
        convert.jsonDecode(Provider.of<LoginInfoModel>(context).value)["id"];

    return Scaffold(
      appBar: AppBar(
        title: new Text("故障订单"),
      ),
      body: ChangeNotifierProvider(
        builder: (context) => OrderListModel(isCheck: isCheck, id: id, page: 0),
        child: MyOrder(),
      ),
    );
  }
}
