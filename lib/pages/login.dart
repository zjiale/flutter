import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fubin/config/route/navigator_util.dart';
import 'package:provider/provider.dart';
import 'package:fubin/model/login_info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  GlobalKey<FormState> _loginInfo = new GlobalKey<FormState>(); //获取form对象
  String _phone;
  String _password;

  ShapeBorder shape = const RoundedRectangleBorder(
      side: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(50)));

  @override
  Widget build(BuildContext context) {
    // 触摸收起键盘
    return new GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        body: Center(

            ///防止overFlow的现象
            child: SafeArea(
          ///同时弹出键盘不遮挡
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 40, right: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Form(
                    key: _loginInfo,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          maxLength: 11,
                          decoration: InputDecoration(hintText: '请输入手机号'),
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
                          decoration: InputDecoration(hintText: '请输入密码'),
                          validator: (pwd) => pwd.isEmpty ? '密码不能为空' : null,
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
                          child: Text('登录',
                              style: TextStyle(color: Colors.blue[200])),
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            var _form = _loginInfo.currentState;

                            if (_form.validate()) {
                              _form.save();
                              Map<String, dynamic> params = {
                                'name': _phone,
                                'pwd': _password
                              };
                              await Provider.of<LoginInfoModel>(context)
                                  .userLogin(params);
                              if (prefs.getString('userInfo') != null) {
                                NavigatorUtil.goHomePage(context);
                                // Navigator.pushAndRemoveUntil(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             BottomNavigation()),
                                //     (route) =>
                                //         route == null); //route ==null 销毁当前页面
                              }
                            }
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
