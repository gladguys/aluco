import 'package:aluco/screen/classes/list_classes/components/save_class_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ClassEmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Icon(Icons.not_interested, size: 120, color: Colors.grey[300],),
              const SizedBox(height: 32),
              const Text('Você ainda não cadastrou nenhuma turma', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 32),
              SaveClassButton(),
            ],
          ),
        ),
      ),
    );
  }
}
