import 'package:aluco/screen/signin/signin_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ALLogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.exit_to_app),
      onPressed: () async {
        BlocProvider.getBloc<SigninBloc>().clearInfo();
      },
    );
  }
}
