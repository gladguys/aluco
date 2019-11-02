import 'package:aluco/screen/home/components/home_actions.dart';
import 'package:aluco/utils/jwt_utils.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: ExactAssetImage('assets/images/owl.png'),
          fit: BoxFit.contain,
          alignment: Alignment.bottomCenter,
          colorFilter: ColorFilter.mode(
            Colors.grey[50],
            BlendMode.softLight,
          ),
        ),
      ),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 24),
          HomeActions(),
        ],
      ),
    );
  }
}
