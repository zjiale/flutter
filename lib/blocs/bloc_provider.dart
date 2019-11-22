import 'package:flutter/material.dart';
import 'package:fubin/blocs/order_list_bloc.dart';

class BlocProvider extends InheritedWidget {
  OrderListBloC orderBloc = OrderListBloC();

  BlocProvider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static OrderListBloC of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider)
          .orderBloc;
}
