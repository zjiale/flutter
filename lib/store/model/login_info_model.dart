import 'package:flutter/material.dart';
import '../bean/login_entity.dart';
import 'package:fubin/config/api.dart';
import 'package:fubin/config/cache.dart';
import 'package:fubin/config/util.dart';

class LoginInfoModel with ChangeNotifier {
  String _key = 'PRES_USER_INFO_KEY';
  String _userInfo;
  String get value => _userInfo;

  Future userLogin(final Map<String, dynamic> params) async {
    return request(path['Login'], params: params).then((res) {
      Login login = new Login(res);
      if (login.success == true) {
        _userInfo = login.datas.toString();
        SpUtil.set2storage(_key, _userInfo);
        notifyListeners();
      } else {
        return login.massege;
      }
    });
  }

  clear() {
    SpUtil.preferences.remove(_key);
  }
}