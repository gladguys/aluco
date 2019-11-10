import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ListEmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Icon(Entypo.getIconData('emoji-sad'), size: 60),
              const SizedBox(height: 32),
              const Text('Nenhum resultado encontrado'),
            ],
          ),
        ),
      ),
    );
  }
}
