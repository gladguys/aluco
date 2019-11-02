import 'package:aluco/screen/home/components/home_actions.dart';
import 'package:aluco/utils/jwt_utils.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 30),
        Text(
          'Oi, ${JWTUtils.getUsername()?.toUpperCase()}',
          style: TextStyle(fontSize: 22),
        ),
        const SizedBox(height: 18),
        CircleAvatar(
          backgroundImage: NetworkImage(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcToXffDWYU6rqNmwErhPEngsrP7FNP0c3RhJxLwLLI4gETXmBLq'),
          radius: 40,
        ),
        const SizedBox(height: 8),
        HomeActions(),
      ],
    );
  }
}
