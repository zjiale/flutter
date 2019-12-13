import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SpinKitWave(
          color: Colors.blue[200],
          type: SpinKitWaveType.center,
        ),
        Text('正在加载数据中')
      ],
    ));
  }
}
