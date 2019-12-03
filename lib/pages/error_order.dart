import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:fubin/model/inherited_check.dart';
import 'package:fubin/pages/my_order.dart';
import 'package:fubin/model/order_list_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class errorOrder extends StatefulWidget {
  @override
  _errorOrderState createState() => _errorOrderState();
}

class _errorOrderState extends State<errorOrder>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;
  var userInfo;

  Map<String, dynamic> params = {"page": 0, "size": 3};

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final int isCheck = InheritedCheck.of(context).check.isCheck;

    Future<String> get() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var user = prefs.getString('userInfo');
      return user;
    }

    Future<String> getUserInfo = get().then((res) {
      userInfo = convert.jsonDecode(res);
      params["id"] = userInfo["id"];
    });

    return Scaffold(
      appBar: AppBar(
        title: new Text("故障订单"),
      ),
      body: ChangeNotifierProvider(
        builder: (context) => OrderListModel(isCheck: isCheck, params: params),
        child: myOrder(),
      ),
    );
  }
}
