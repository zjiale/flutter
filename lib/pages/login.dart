import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fubin/model/login_info_model.dart';

class login extends StatelessWidget {
  GlobalKey<FormState> _loginInfo = new GlobalKey<FormState>(); //获取form对象
  String _phone;
  String _password;

  ShapeBorder shape = const RoundedRectangleBorder(
      side: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(50)));

  void _formSubmitted(BuildContext context) {
    var _form = _loginInfo.currentState;

    if (_form.validate()) {
      _form.save();
      Map<String, dynamic> params = {'name': _phone, 'pwd': _password};
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<LoginInfoModel>(context).userLogin(params);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginStatus = Provider.of<LoginInfoModel>(context).loginStatus;
    return Scaffold(
      body: Center(
          child: Container(
        padding: EdgeInsets.only(left: 100, right: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _loginInfo,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    maxLength: 11,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: '请输入手机号'),
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    validator: (phone) =>
                        phone.length < 11 ? '请输入正确的手机号' : null,
                    onSaved: (phone) {
                      _phone = phone;
                    },
                  ),
                  TextFormField(
                    obscureText: true, //是否隐藏密码
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '请输入密码',
                    ),
                    validator: (pwd) => pwd.length <= 0 ? '密码不能为空' : null,
                    onSaved: (pwd) {
                      _password = pwd;
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: OutlineButton(
                    shape: shape,
                    borderSide: BorderSide(color: Colors.blue[200]),
                    highlightedBorderColor: Colors.blue[200],
                    child:
                        Text('登录', style: TextStyle(color: Colors.blue[200])),
                    onPressed: () {
                      _formSubmitted(context);
                    },
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
