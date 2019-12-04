import 'package:flutter/material.dart';
import 'package:fubin/bean/login_entity.dart';
import 'package:fubin/config/api.dart';
import 'package:fubin/config/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginInfoModel with ChangeNotifier {
  String _userInfo;
  String get value => _userInfo;

  userLogin(final Map<String, dynamic> params) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return request(path['Login'], params: params).then((res) {
      Login login = new Login(res);
      if (login.code == 0) {
        _userInfo = login.datas.toString();
        prefs.setString('userInfo', login.datas.toString());
        notifyListeners();
      }
    });
  }
}
