import 'package:flutter/material.dart';
import 'package:fubin/bean/login_entity.dart';
import 'package:fubin/config/api.dart';
import 'package:fubin/config/util.dart';

class LoginInfoModel with ChangeNotifier {
  String _userInfo;
  String get value => _userInfo;

  userLogin(final Map<String, dynamic> params) async {
    return request(path['Login'], params: params).then((res) {
      Login login = new Login(res);
      if (login.code == 0) {
        _userInfo = login.datas.toString();
        notifyListeners();
      }
    });
  }

  clear() {
    _userInfo = null;
  }
}
