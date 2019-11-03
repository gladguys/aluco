import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ALWaitingIndicator extends StatelessWidget {
  const ALWaitingIndicator({this.size = 50});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitWave(
        color: Theme.of(context).primaryColor,
        size: size,
      ),
    );
  }
}
