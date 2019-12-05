import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class detailInfo extends StatefulWidget {
  @override
  _detailInfoState createState() => _detailInfoState();

  int isCheck;
  String oid;
  List orderList;
  detailInfo(
      {Key key,
      @required this.isCheck,
      @required this.oid,
      @required this.orderList})
      : super(key: key);
}

class _detailInfoState extends State<detailInfo> {
  static const TextStyle userInfo =
      TextStyle(fontSize: 17, fontWeight: FontWeight.bold);

  // 转单
  Future<void> _transferTask() async {
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
                print('确定');
              },
            ),
          ],
        );
      },
    );
  }

  // 上传照片
  Future _uploadImg() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  @override
  Widget build(BuildContext context) {
    var detailInfo =
        widget.orderList.firstWhere((item) => item.msgId == widget.oid);
    print(detailInfo);

    final Widget name = Container(
        margin: EdgeInsets.only(left: 5),
        child: Row(
          children: <Widget>[
            Text('姓名:', style: userInfo),
            Text(detailInfo.name, style: userInfo)
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
                detailInfo.phone,
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
              onSelected: (String message) {
                print(message.toString());
              },
              itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                PopupMenuItem(child: Text('拨打'), value: '拨打'),
                PopupMenuItem(child: Text('复制'), value: '复制')
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
                Text(detailInfo.faulttype, style: userInfo),
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
                  detailInfo.createTime,
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
                detailInfo.address,
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
      child: Text(detailInfo.msg, maxLines: 4),
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
                  _transferTask();
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

    return Container(
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
    );
  }
}
