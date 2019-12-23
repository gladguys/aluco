import 'package:flutter/material.dart';

class ALFallbackUserImage extends StatelessWidget {
  const ALFallbackUserImage(this.imageUrl, {this.width, this.height});

  final String imageUrl;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
