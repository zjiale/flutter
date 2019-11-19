import 'package:flutter/material.dart';

class detailInfo extends StatefulWidget {
  @override
  _detailInfoState createState() => _detailInfoState();
}

class _detailInfoState extends State<detailInfo> {
  final userInfo = const TextStyle(fontSize: 17, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('姓名:', style: userInfo),
              Text('测试测试', style: userInfo)
            ],
          ),
          Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: <Widget>[
                  Text('电话:', style: userInfo),
                  Padding(
                    padding: EdgeInsets.only(top: 3, right: 5),
                    child: Text(
                      '15602295985',
                      style: TextStyle(
                          fontSize: 17,
                          color: Color(0xFF2196F3),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  PopupMenuButton<String>(
                    initialValue: "",
                    child: Text('(点击此处拨打或复制)',
                        style:
                            TextStyle(fontSize: 15, color: Color(0xFF3ABBFF))),
                    onSelected: (String message) {
                      print(message.toString());
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuItem<String>>[
                      PopupMenuItem(child: Text('拨打'), value: '拨打'),
                      PopupMenuItem(child: Text('复制'), value: '复制')
                    ],
                  )
                ],
              )),
          Card(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('水龙头故障', style: userInfo),
                      Text('现代学院',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3ABBFF)))
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                  ),
                  Row(
                    children: <Widget>[
                      Image.asset("images/time.png", width: 23, height: 23),
                      Padding(
                        padding: EdgeInsets.only(right: 6),
                      ),
                      Text(
                        '2019-11-19 09:57:14',
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Row(children: <Widget>[
                    Image.asset("images/address.png", width: 23, height: 23),
                    Padding(
                      padding: EdgeInsets.only(right: 6),
                    ),
                    Text(
                      '现代学院9栋9999',
                      style: TextStyle(fontSize: 15),
                    )
                  ])
                ],
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 10, bottom: 5)),
          Padding(
              padding: EdgeInsets.only(left: 5),
              child: Row(
                children: <Widget>[
                  Text('备注',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  // Divider()
                ],
              ))
        ],
      ),
    );
  }
}
