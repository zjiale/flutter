import 'dart:io';

import 'package:flutter/material.dart';
import '../bean/change_entity.dart';
import 'package:fubin/config/api.dart';
import 'package:fubin/config/util.dart';

class ChangeMsgModel with ChangeNotifier {
  int _code;
  int get value => _code;

  Future changeMsg(final Map<String, dynamic> params) {
    return request(path['ChangeMsg'], params: params).then((res) {
      Change change = new Change(res);
      if (change.success == true) {
        _code = change.code;
        notifyListeners();
      } else {
        return change.massege;
      }
    });
  }

  Future finshMsg(List<File> _imgFile) {
    return request(path['UploadImg'], params: _imgFile).then((res) {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
