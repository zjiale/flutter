import 'package:flutter/material.dart';
import 'package:fubin/pages/error_order.dart';
import 'package:fubin/pages/personal.dart';
import 'package:fubin/store/index.dart' show Store, IsCheckModel;
import 'package:provider/provider.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;
  List<Widget> _pages;
  // BottomNavigation KeepAlive
  PageController _controller;

  @override
  void initState() {
    super.initState();
    _pages = List()
      ..add(ErrorOrder())
      ..add(Personal()); // ..为数组得连续调用不需要每次都重新写_pages.add
    _controller = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        physics: NeverScrollableScrollPhysics(), //pageview 禁止左右滑动
        onPageChanged: _pageChange,
        controller: _controller,
        itemCount: _pages.length,
        itemBuilder: (context, index) => _pages[index],
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: getItems(),
          selectedItemColor: Colors.amber[800],
          currentIndex: _currentIndex,
          onTap: _onTapItemSelected,
          type: BottomNavigationBarType.fixed),
    );
  }

  List<BottomNavigationBarItem> getItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title: Text('故障订单'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        title: Text('我的'),
      )
    ];
  }

  void _onTapItemSelected(int index) {
    _controller.jumpToPage(index);
  }

  void _pageChange(int index) {
    if (index != _currentIndex) {
      setState(() {
        // Store.value<IsCheckModel>(context).change(index);
        Provider.of<IsCheckModel>(context).change(index);
        _currentIndex = index;
      });
    }
  }
}
