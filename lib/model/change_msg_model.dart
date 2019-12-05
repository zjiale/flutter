import 'package:flutter/material.dart';
import 'package:fubin/bean/change_entity.dart';
import 'package:fubin/config/api.dart';
import 'package:fubin/config/util.dart';

class ChangeMsgModel with ChangeNotifier {
  int _code;
  int get value => _code;

  Future changeMsg(final Map<String, dynamic> params) {
    return request(path['ChangeMsg'], params: params).then((res) {
      Change change = new Change(res);
      if (change.code == 0) {
        _code = change.code;
        notifyListeners();
      }
    });
  }
}
