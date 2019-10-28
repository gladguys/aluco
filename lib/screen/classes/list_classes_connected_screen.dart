import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';

import 'class_bloc.dart';
import 'list_classes_screen.dart';

class ListClassesConnectedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ClassBloc>(
      creator: (context, _) => ClassBloc(),
      child: ListClassesScreen(),
    );
  }
}
