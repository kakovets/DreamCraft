import 'package:flutter/material.dart';
import '../theme/theme.dart';

class BackgroundGradient extends StatelessWidget {
  const BackgroundGradient({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Theme.of(context).extension<MyColors>()!
                .backgroundGradientFirst,
            Theme.of(context).extension<MyColors>()!
                .backgroundGradientSecond,
          ],
        ),
      ),
      child: child,
    );
  }
}