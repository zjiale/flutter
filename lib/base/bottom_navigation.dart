import 'package:flutter/material.dart';
import 'package:fubin/bean/check_entity.dart';
import 'package:fubin/model/inherited_check.dart';
import 'package:fubin/pages/error_order.dart';
import 'package:fubin/pages/personal.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;
  List<Widget> pages = List();
  Check check;

  _initData() {
    // 初始化InheritedWidget里要传得数值
    check = new Check(0);
  }

  @override
  void initState() {
    _initData();
    pages..add(errorOrder())..add(personal()); // ..为数组得连续调用不需要每次都重新写pages.add
    super.initState();
  }

  void _onTapItemSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InheritedCheck(
        check: check,
        child: Scaffold(
            body: pages[_currentIndex],
            bottomNavigationBar: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    title: Text('故障订单'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    title: Text('我的'),
                  )
                ],
                selectedItemColor: Colors.amber[800],
                currentIndex: _currentIndex,
                onTap: _onTapItemSelected,
                type: BottomNavigationBarType.fixed)));
  }
}
