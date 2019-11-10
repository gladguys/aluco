import 'package:aluco/screen/classes/list_classes/components/save_class_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ClassEmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Você ainda não adicionou nenhuma turma.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 48),
              SaveClassButton(isFloating: false),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
