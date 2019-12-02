import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fubin/base/loading.dart';
import 'package:fubin/model/inherited_check.dart';
import 'package:fubin/pages/detail_info.dart';
import 'package:fubin/base/custom_route.dart';
import 'package:fubin/model/order_list_model.dart';
import 'package:provider/provider.dart';

class myOrder extends StatefulWidget {
  @override
  _myOrderState createState() => _myOrderState();
}

class _myOrderState extends State<myOrder> with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<OrderListModel>(context).getOrder();
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderList = Provider.of<OrderListModel>(context).orderList;

    final isCheck = InheritedCheck.of(context).check.isCheck;

    List list = orderList != null ? orderList : [];
    if (list.length > 0) {
      return Container(
          margin: EdgeInsets.all(5.0),
          child: ListView.builder(
            padding: EdgeInsets.only(bottom: 8.0),
            itemCount: list.length,
            itemBuilder: (contex, i) {
              return GestureDetector(
                child: _detailInfo(list[i]),
                onTap: () => _toDetailInfo(context, isCheck),
              );
            },
          ));
    } else {
      return Container(
        child: loading(),
      );
    }
  }
}

Widget _detailInfo(var orderList) {
  final info = const TextStyle(fontSize: 13.0);
  final remark = const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold);

  return Card(
      child: Padding(
    padding: EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 12.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(orderList.address, style: info),
                  Container(
                    margin: EdgeInsets.only(left: 7.0),
                    padding: EdgeInsets.all(1.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Colors.green[200], width: 1),
                        borderRadius: BorderRadius.circular(3.0)),
                    child: Text(
                      orderList.faulttype,
                      style:
                          TextStyle(fontSize: 10.0, color: Colors.green[200]),
                    ),
                  )
                ],
              ),
            ),
            Text(orderList.createTime, style: info)
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Row(
            children: <Widget>[
              Text('备注:', style: remark),
              Text(orderList.msg, style: remark)
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(children: <Widget>[
              Text('姓名:', style: info),
              Padding(
                  padding: EdgeInsets.only(right: 5.0),
                  child: Text(orderList.name, style: info)),
              Row(
                children: <Widget>[
                  Text('电话:', style: info),
                  Padding(
                    padding: EdgeInsets.only(top: 3.0),
                    child:
                        Text(orderList.phone, style: TextStyle(fontSize: 12.0)),
                  )
                ],
              )
            ]),
            Text(
              orderList.isOk == 'N' ? '进行中' : '已完成',
              style: TextStyle(color: Colors.orange[200]),
            )
          ],
        )
      ],
    ),
  ));
}

_toDetailInfo(BuildContext context, int isCheck) {
  Navigator.of(context).push(CustomRoute(new Scaffold(
    appBar: AppBar(title: Text('订单详情')),
    body: detailInfo(isCheck: isCheck),
  )));
}
