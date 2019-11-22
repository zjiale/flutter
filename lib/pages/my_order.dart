import 'package:flutter/material.dart';
import 'package:fubin/pages/detail_info.dart';
import 'package:fubin/base/custom_route.dart';
import 'package:fubin/config/api.dart';
import 'package:fubin/config/util.dart';
import 'package:fubin/bean/order.dart';

class myOrder extends StatefulWidget {
  @override
  _myOrderState createState() => _myOrderState();

  myOrder({Key key, @required this.isCheck}) : super(key: key);
  final int isCheck;
}

class _myOrderState extends State<myOrder> with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;
  List orderList = [];

  @override
  void initState() {
    super.initState();
    this._getOrder();
  }

  // 获取首页订单数据
  _getOrder() {
    print(123);
    int isCheck = widget.isCheck;
    // 需要借助工具把需要解析的对象生成对应的实体类，之后才能够借助工具进行解析
    Map<String, dynamic> params = {
      "id": "10DCCFAE9F3E4E9D926ADED2A8953A50",
      "page": 0,
      "size": 3
    };
    request(isCheck == 0 ? path['GetOrder'] : path['GetSuccessOrder'],
            params: params)
        .then((res) {
      Order order = new Order(res);
      if (order.code == 0) {
        // setState(() {
        //   widget.isCheck == 0
        //       ? orderList =
        //           order.datas.where((item) => item.isOk == 'N').toList()
        //       : orderList = order.datas;
        // });
        setState(() {
          orderList = order.datas;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5.0),
        child: ListView.builder(
          padding: EdgeInsets.only(bottom: 8.0),
          itemCount: orderList.length,
          itemBuilder: (contex, i) {
            return GestureDetector(
              child: _detailInfo(orderList[i]),
              onTap: () => _toDetailInfo(context, widget.isCheck),
            );
          },
        ));
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
