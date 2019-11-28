import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        SpinKitWave(
          color: Colors.white,
          type: SpinKitWaveType.center,
        ),
        Text('正在加载数据中')
      ],
    ));
  }
}
