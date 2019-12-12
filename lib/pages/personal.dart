import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:fubin/base/split.dart';
import 'package:fubin/config/cache.dart';
import 'package:fubin/config/route/navigator_util.dart';
import 'package:fubin/store/index.dart'
    show Store, IsCheckModel, LoginInfoModel, OrderListModel;

class Personal extends StatefulWidget {
  @override
  _PersonalState createState() => _PersonalState();
}

class _PersonalState extends State<Personal>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  static const String _StorageKey = 'PRES_USER_INFO_KEY';
  var userInfo = convert.jsonDecode(SpUtil.preferences.get(_StorageKey));

  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.of(context).size;

    // 样式布局
    Widget _userInfo() {
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
                            userInfo["name"],
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        new Text(
                          userInfo["phone"],
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

    Widget _buttonOption() {
      return new Container(
          width: size.width,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0))),
          child: Store.connect3<IsCheckModel, LoginInfoModel, OrderListModel>(
              builder: (context, check, login, order, child) {
            return Column(
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.reorder),
                    title: Text('我的订单'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // print(check.value);
                      final String id = userInfo["id"];
                      NavigatorUtil.goSuccessOrder(context, check.value, id, 0);
                    }),
                ListTile(
                  leading: Icon(Icons.power_settings_new),
                  title: Text('退出登录'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    login.clear();
                    NavigatorUtil.logout(context);
                  },
                ),
                new split(),
                ListTile(
                    leading: Icon(Icons.perm_data_setting),
                    title: Text('系统设置'),
                    trailing: Icon(Icons.arrow_forward_ios)),
              ],
            );
          }));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: <Widget>[
        _userInfo(),
        Container(
          color: Colors.blue,
          child: _buttonOption(),
        )
      ]),
    );
  }
}
