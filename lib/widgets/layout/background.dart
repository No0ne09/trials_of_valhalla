import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              'assets/images/background_${size.width > size.height ? 'landscape' : 'portrait'}.png',
            ),
            fit: BoxFit.fitWidth),
      ),
      child: Center(child: child),
    );
  }
}
