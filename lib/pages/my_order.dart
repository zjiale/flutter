import 'package:flutter/material.dart';
import 'package:fubin/base/loading.dart';
import 'package:fubin/config/route/navigator_util.dart';
import 'package:fubin/store/index.dart'
    show Store, IsCheckModel, OrderListModel;

import 'package:provider/provider.dart';

class MyOrder extends StatefulWidget {
  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  var orderList;
  // int isCheck;
  bool isLoading = false; //是否正在请求新数据
  bool offState = false; //是否显示进入页面时的圆形进度条

  /* 字体样式 */
  final info = const TextStyle(fontSize: 13.0);
  final remark = const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
    getOrderList();
  }

  @override
  Widget build(BuildContext context) {
    var check = Store.value<IsCheckModel>(context);
    var order = Store.value<OrderListModel>(context);
    return Stack(
      children: <Widget>[
        Store.connect<OrderListModel>(builder: (context, snapshot, child) {
          if (check.value == 1) order.getOrder();
          var list = orderList != null ? orderList : order.value;
          return _createListView(context, check.value, list);
        }),
        Offstage(
          offstage: offState,
          child: loading(),
        )
      ],
    );
  }

  /* ListView布局 */
  Widget _createListView(BuildContext context, int isCheck, List orderList) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: Container(
          margin: EdgeInsets.all(5.0),
          child: ListView.builder(
            padding: EdgeInsets.only(bottom: 8.0),
            itemCount: orderList.length,
            itemBuilder: (contex, i) {
              return GestureDetector(
                  child: _detailInfo(orderList[i]),
                  onTap: () {
                    print(isCheck);
                    NavigatorUtil.goDetailInfo(context, isCheck, orderList[i])
                        .then((result) {
                      if (result == "refresh") _onRefresh();
                    });
                  }
                  // _toDetailInfo(context, isCheck, list[i].msgId, list),
                  );
            },
          )),
    );
  }

  /* 详情布局 */
  Widget _detailInfo(var orderList) {
    return Card(
        child: Padding(
      padding: EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(orderList.address, style: info),
                    Container(
                      margin: EdgeInsets.only(left: 7.0),
                      padding: EdgeInsets.all(1.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border:
                              Border.all(color: Colors.green[200], width: 1),
                          borderRadius: BorderRadius.circular(3.0)),
                      child: Text(
                        orderList.faulttype,
                        style:
                            TextStyle(fontSize: 10.0, color: Colors.green[200]),
                      ),
                    )
                  ],
                ),
              ),
              Text(orderList.createTime, style: info)
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Row(
              children: <Widget>[
                Text('备注:', style: remark),
                Text(orderList.msg, style: remark)
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(children: <Widget>[
                Text('姓名:', style: info),
                Padding(
                    padding: EdgeInsets.only(right: 5.0),
                    child: Text(orderList.name, style: info)),
                Row(
                  children: <Widget>[
                    Text('电话:', style: info),
                    Padding(
                      padding: EdgeInsets.only(top: 3.0),
                      child: Text(orderList.phone,
                          style: TextStyle(fontSize: 12.0)),
                    )
                  ],
                )
              ]),
              Text(
                orderList.isOk == 'N' ? '进行中' : '已完成',
                style: TextStyle(color: Colors.orange[200]),
              )
            ],
          )
        ],
      ),
    ));
  }

  /* 初始化页面数据 */
  void getOrderList() async {
    if (isLoading) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
        offState = true;
      });
    });
  }

  /* 下拉刷新 */
  Future<void> _onRefresh() async {
    if (isLoading) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    Provider.of<OrderListModel>(context).getOrder();
    await Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
        orderList = Store.value<OrderListModel>(context).value;
      });
    });
  }
}
