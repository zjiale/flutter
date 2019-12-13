import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fubin/base/Toast.dart';
import 'package:fubin/config/TelAndSmsService.dart';
import 'package:fubin/config/route/navigator_util.dart';
import 'package:fubin/config/util.dart';
import 'package:fubin/store/index.dart' show Store, ChangeMsgModel;
import 'package:image_picker/image_picker.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

class DetailInfo extends StatefulWidget {
  @override
  _DetailInfoState createState() => _DetailInfoState();

  int isCheck;
  String oid;
  Map<String, dynamic> orderInfo;
  DetailInfo({Key key, @required this.isCheck, @required this.orderInfo})
      : super(key: key);
}

class _DetailInfoState extends State<DetailInfo> {
  static const TextStyle userInfo =
      TextStyle(fontSize: 17, fontWeight: FontWeight.bold);
  final TelAndSmsService _service = locator<TelAndSmsService>();
  TextEditingController _phoneController = TextEditingController();

  String debugLable = 'Unknown'; /*错误信息*/
  final JPush jpush = new JPush(); /* 初始化极光插件*/

  @override
  void initState() {
    super.initState();
    initPlatformState(); /*极光插件平台初始化*/
  }

  // 推送测试
  Future<void> initPlatformState() async {
    String platformVersion;

    try {
      /*监听响应方法的编写*/
      jpush.addEventHandler(
          onReceiveNotification: (Map<String, dynamic> message) async {
        print(">>>>>>>>>>>>>>>>>flutter 接收到推送: $message");
        setState(() {
          debugLable = "接收到推送: $message";
        });
      });
    } on PlatformException {
      platformVersion = '平台版本获取失败，请检查！';
    }

    if (!mounted) {
      return;
    }

    setState(() {
      debugLable = platformVersion;
    });
  }

  // 转单
  Future<void> _transferTask(
      ChangeMsgModel change, String msgId, String userId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('转单电话'),
          content: SingleChildScrollView(
            child: TextField(
              autofocus: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: '在此输入对方的电话号码'),
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly // 限制只输入数字
              ],
              controller: _phoneController,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('确定'),
              onPressed: () {
                // 关闭键盘
                FocusScope.of(context).requestFocus(FocusNode());
                RegExp reg = new RegExp(
                    '^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$');
                if (!reg.hasMatch(_phoneController.text)) {
                  Toast.toast(context,
                      msg: "请输入正确的手机号", position: ToastPostion.bottom);
                } else {
                  Map<String, dynamic> params = {
                    "id": userId,
                    "msgId": msgId,
                    "phone": _phoneController.text
                  };
                  change.changeMsg(params).then((res) {
                    if (change.value == 0) {
                      _phoneController.text = "";
                      Navigator.of(context).pop();
                      Toast.toast(context,
                          msg: "转单成功", position: ToastPostion.bottom);
                    } else {
                      Toast.toast(context,
                          msg: "$res", position: ToastPostion.bottom);
                    }
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  // 上传照片
  Future _uploadImg() async {
    File _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (_imageFile != null) {
      /*三秒后出发本地推送*/
      var fireDate = DateTime.fromMillisecondsSinceEpoch(
          DateTime.now().millisecondsSinceEpoch + 3000);
      var localNotification = LocalNotification(
        id: 234,
        title: '只是一个简单的推送测试',
        buildId: 1,
        content: '已经选择了一张图片了',
        fireTime: fireDate,
        subtitle: '推送测试',
      );
      jpush.sendLocalNotification(localNotification).then((res) {
        setState(() {
          debugLable = res;
        });
      });
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    var detailInfo = widget.orderInfo;
    ChangeMsgModel change = Store.value<ChangeMsgModel>(context);

    final Widget name = Container(
        margin: EdgeInsets.only(left: 5),
        child: Row(
          children: <Widget>[
            Text('姓名:', style: userInfo),
            Text(detailInfo["name"], style: userInfo)
          ],
        ));

    final Widget phone = Container(
        margin: EdgeInsets.fromLTRB(5, 10, 0, 10),
        child: Row(
          children: <Widget>[
            Text('电话:', style: userInfo),
            Padding(
              padding: EdgeInsets.only(top: 3, right: 5),
              child: Text(
                detailInfo["phone"],
                style: TextStyle(
                    fontSize: 17,
                    color: Color(0xFF2196F3),
                    fontWeight: FontWeight.bold),
              ),
            ),
            PopupMenuButton<String>(
              initialValue: "",
              child: Text('(点击此处拨打或复制)',
                  style: TextStyle(fontSize: 15, color: Color(0xFF3ABBFF))),
              onSelected: (String action) {
                switch (action) {
                  case "call":
                    _service.call(detailInfo["phone"]);
                    break;
                  case "copy":
                    copy2clipboard(detailInfo["phone"]);
                    break;
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                PopupMenuItem(child: Text('拨打'), value: 'call'),
                PopupMenuItem(child: Text('复制'), value: 'copy')
              ],
            )
          ],
        ));

    final Widget errorDesc = Card(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(detailInfo["faulttype"], style: userInfo),
                Text(detailInfo["address"].substring(0, 4),
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
                  detailInfo["createTime"],
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
                detailInfo["address"],
                style: TextStyle(fontSize: 15),
              )
            ])
          ],
        ),
      ),
    );

    final Widget remarkTitle = Padding(
        padding: EdgeInsets.only(left: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 8),
                child: Text('备注',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
            Expanded(
              flex: 1,
              child: Padding(
                  padding: EdgeInsets.only(top: 2, right: 5),
                  child: Divider(height: 1.0, color: Colors.grey)),
            )
          ],
        ));

    final Widget remarkContent = Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10, left: 15),
      child: Text(detailInfo["msg"], maxLines: 4),
    );

    final Widget controlBtn = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Theme(
          data: Theme.of(context).copyWith(
              buttonTheme: ButtonThemeData(
                  padding: EdgeInsets.symmetric(horizontal: 16.0))),
          child: ButtonBar(
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  _transferTask(
                      change, detailInfo["msgId"], detailInfo["appUserId"]);
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[Text('转单'), Text('输入电话可转单')],
                  ),
                ),
                color: Colors.lightBlue[100],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
              ),
              FlatButton(
                onPressed: () {
                  _uploadImg();
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[Text('完成'), Text('点击确定完成-拍照')],
                  ),
                ),
                color: Colors.lightBlue[100],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
              )
            ],
          ),
        )
      ],
    );

    return WillPopScope(
      onWillPop: () {
        NavigatorUtil.goBackHomePage(context, "refresh");
        // onWillPop需要一个bool返回值，true表示退出，false表示不退出
        return Future.value(false);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                name,
                phone,
                errorDesc,
                Padding(padding: EdgeInsets.only(top: 10, bottom: 5)),
                remarkTitle,
                remarkContent,
              ],
            ),
            Offstage(
                offstage: widget.isCheck == 0 ? false : true, child: controlBtn)
          ],
        ),
      ),
    );
  }
}
