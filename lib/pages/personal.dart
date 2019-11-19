import 'package:flutter/material.dart';
import 'package:fubin/pages/my_order.dart';
import 'package:fubin/base/split.dart';

class personal extends StatefulWidget {
  @override
  _personalState createState() => _personalState();
}

class _personalState extends State<personal>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: <Widget>[
        _userInfo(size),
        Container(
          color: Colors.blue,
          child: _buttonOption(size, context),
        )
      ]),
    );
  }
}

// 样式布局
Widget _userInfo(Size size) {
  final String _src =
      'https://platform-wxmall.oss-cn-beijing.aliyuncs.com/upload/20180727/150547696d798c.png';

  return new Container(
    width: size.width,
    padding: EdgeInsets.only(top: 60.0),
    color: Colors.blue,
    child: new Row(
      children: <Widget>[
        new Padding(
          padding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 50.0),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 20.0),
                child: CircleAvatar(
                    radius: 36.0, backgroundImage: NetworkImage(_src)),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, //头部对齐
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 15.0),
                      child: new Text(
                        "帅哥",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    new Text(
                      '15602295985',
                      style: TextStyle(color: Colors.white),
                    )
                  ])
            ],
          ),
        )
      ],
    ),
  );
}

Widget _buttonOption(Size size, BuildContext context) {
  return new Container(
    width: size.width,
    decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0))),
    child: Column(
      children: <Widget>[
        ListTile(
            leading: Icon(Icons.reorder),
            title: Text('我的订单'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              _toMyOrder(context);
            }),
        ListTile(
            leading: Icon(Icons.power_settings_new),
            title: Text('退出登录'),
            trailing: Icon(Icons.arrow_forward_ios)),
        new split(),
        ListTile(
            leading: Icon(Icons.perm_data_setting),
            title: Text('系统设置'),
            trailing: Icon(Icons.arrow_forward_ios)),
      ],
    ),
  );
}

// function
_toMyOrder(BuildContext context) {
  Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('我的订单'),
      ),
      body: myOrder(),
    );
  }));
}
