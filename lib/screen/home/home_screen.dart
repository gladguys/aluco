import 'package:aluco/core/utils/global_keys.dart';
import 'package:aluco/widget/al_logo.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/dialog/gg_dialog.dart';
import 'package:ndialog/ndialog.dart';

import 'components/home.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ALScaffold(
      titleWidget: ALLogo(
        color: Theme.of(context).primaryColor,
        fontSize: 40,
        hasShadow: false,
      ),
      actions: <Widget>[
        Container(
          key: profileKey,
          width: 32,
          height: 32,
          margin: const EdgeInsets.only(left: 4, right: 12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: const AssetImage('assets/images/user.png'),
              fit: BoxFit.contain,
            ),
          ),
          child: FlatButton(
            padding: const EdgeInsets.all(0),
            shape: CircleBorder(),
            highlightColor: Colors.white10,
            splashColor: Colors.white30,
            onPressed: () {
              GGDialog.show(
                context,
                NAlertDialog(
                  dialogStyle: DialogStyle(
                    borderRadius: BorderRadius.circular(24),
                    contentPadding: const EdgeInsets.all(16),
                  ),
                  blur: 3,
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image:
                                const AssetImage('assets/images/user120.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Osvaldo Lourenço Filho',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'cristianoosvaldo@fortalezaec.com',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 32),
                      OutlineButton(
                        child: const Text('SAIR'),
                        color: Colors.red[600],
                        textColor: Colors.red[600],
                        borderSide: BorderSide(color: Colors.red[200]),
                        highlightedBorderColor: Colors.red[300],
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
              );
            },
            child: null,
          ),
        ),
      ],
      body: Home(),
    );
  }
}
