import 'package:aluco/core/routing/al_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gg_flutter_components/gg_flutter_components.dart';
import 'package:gg_flutter_components/gg_snackbar.dart';

class ALIconTextVerticalButton extends StatelessWidget {
  const ALIconTextVerticalButton({
    this.icon,
    this.text,
    this.route,
    this.resolver,
    this.condition = true,
    this.message,
  });

  final IconData icon;
  final String text;
  final Widget route;
  final Function resolver;
  final bool condition;
  final String message;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return GGIconLabelContainer(
      icon: Icon(
        icon,
        size: 48,
        color: theme.accentColor,
      ),
      text: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: theme.accentColor,
          ),
        ),
      ),
      width: 140,
      height: 120,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      backgroundColor: Colors.white,
      borderWidth: 1,
      withShadow: true,
      onTap: () async {
        if (condition) {
          ALRouter.pushWithResolver(context, route, resolver);
        } else {
          GGSnackbar.warning(message: message, context: context);
        }
      },
    );
  }
}
