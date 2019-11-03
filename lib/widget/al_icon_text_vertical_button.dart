import 'package:aluco/routing/al_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gg_flutter_components/gg_flutter_components.dart';

class ALIconTextVerticalButton extends StatelessWidget {
  const ALIconTextVerticalButton({
    this.icon,
    this.text,
    this.route,
  });
  
  final IconData icon;
  final String text;
  final Widget route;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    
    return GGIconLabelContainer(
      icon: Icon(
        icon,
        size: 60,
        color: theme.accentColor,
      ),
      text: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          color: theme.accentColor,
        ),
      ),
      width: 140,
      height: 120,
      backgroundColor: Colors.white,
      borderWidth: 1,
      withShadow: true,
      onTap: () => ALRouter.push(context, route),
    );
  }
}