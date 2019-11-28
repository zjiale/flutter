import 'package:flutter/material.dart';
import 'package:fubin/bean/login_entity.dart';
import 'package:fubin/config/api.dart';
import 'package:fubin/config/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginInfoModel with ChangeNotifier {
  int loginStatus;
  int get value => loginStatus;

  userLogin(final Map<String, dynamic> params) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    request(path['Login'], params: params).then((res) {
      Login login = new Login(res);
      if (login.code == 0) {
        loginStatus = login.code;
        prefs.setString('userId', login.datas.id);
        notifyListeners();
      }
    });
  }
}
