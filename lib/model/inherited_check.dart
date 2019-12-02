import 'package:flutter/material.dart';
import 'package:fubin/bean/check_entity.dart';

class InheritedCheck extends InheritedWidget {
  final Check check;

  //方便其子Widget在Widget树中找到它
  static InheritedCheck of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(InheritedCheck) as InheritedCheck;

  InheritedCheck({Key key, @required this.check, @required Widget child})
      : super(key: key, child: child);

  // 判断是否需要更新
  @override
  bool updateShouldNotify(InheritedCheck oldWidget) => check != oldWidget.check;
}
