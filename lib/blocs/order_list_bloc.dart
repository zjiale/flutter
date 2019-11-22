import 'dart:async';

class OrderListBloC {
  List _orderList = [];
  var _orderListController = StreamController<List>.broadcast();

  Stream<List> get stream => _orderListController.stream;
  List get value => _orderList;

  dispose() {
    _orderListController.close();
  }
}
