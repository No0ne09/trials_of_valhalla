import 'package:flutter/material.dart';
import 'package:trials_of_valhalla/helpers/theme.dart';
import 'package:trials_of_valhalla/widgets/layout/background.dart';

class ComplexScreenBase extends StatelessWidget {
  const ComplexScreenBase({
    required this.title,
    required this.child,
    required this.divider,
    super.key,
  });
  final String title;
  final Widget child;
  final double divider;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          title,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                fontFamily: defaultFontFamily,
              ),
        ),
        centerTitle: true,
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
      ),
      body: Background(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width / divider,
            child: child,
          ),
        ),
      ),
    );
  }
}
