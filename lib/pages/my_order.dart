import 'package:flutter/material.dart';
import 'package:fubin/pages/detail_info.dart';
import 'package:fubin/base/custom_route.dart';

class myOrder extends StatefulWidget {
  @override
  _myOrderState createState() => _myOrderState();
}

class _myOrderState extends State<myOrder> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5.0),
        child: ListView.builder(
          padding: EdgeInsets.only(bottom: 8.0),
          itemCount: 1,
          itemBuilder: (contex, i) {
            return GestureDetector(
              child: _detailInfo(),
              onTap: () => _toDetailInfo(context),
            );
            // return new FlatButton(
            //   child:
            //   onPressed: () => _toDetailInfo(),
            // );
          },
        ));
  }
}

Widget _detailInfo() {
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
                  Text('现代学院2栋6666', style: info),
                  Container(
                    margin: EdgeInsets.only(left: 7.0),
                    padding: EdgeInsets.all(1.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Colors.green[200], width: 1),
                        borderRadius: BorderRadius.circular(3.0)),
                    child: Text(
                      '水龙头故障',
                      style:
                          TextStyle(fontSize: 10.0, color: Colors.green[200]),
                    ),
                  )
                ],
              ),
            ),
            Text('1小时前', style: info)
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Row(
            children: <Widget>[
              Text('备注:', style: remark),
              Text('水龙头坏了', style: remark)
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
                  child: Text('帅哥', style: info)),
              Row(
                children: <Widget>[
                  Text('电话:', style: info),
                  Padding(
                    padding: EdgeInsets.only(top: 3.0),
                    child:
                        Text('15602295985', style: TextStyle(fontSize: 12.0)),
                  )
                ],
              )
            ]),
            Text(
              '已完成',
              style: TextStyle(color: Colors.orange[200]),
            )
          ],
        )
      ],
    ),
  ));
}

_toDetailInfo(BuildContext context) {
  Navigator.of(context).push(CustomRoute(new Scaffold(
    appBar: AppBar(title: Text('订单详情')),
    body: detailInfo(),
  )));
}
