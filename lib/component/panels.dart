import 'package:flutter/material.dart';

class ThemeAwareCard extends StatelessWidget {
  final Widget child;

  const ThemeAwareCard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      color: theme.backgroundColor,
      decoration: BoxDecoration(border: Border.all(color: Color(0xFF444c56))),
      child: child,
    );
  }
}

class EndOfSection extends StatelessWidget {
  const EndOfSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).shadowColor;
    double size = 14;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.circle,
          size: size,
          color: color,
        ),
        Icon(
          Icons.circle,
          size: size,
          color: color,
        ),
        Icon(
          Icons.circle,
          size: size,
          color: color,
        )
      ],
    );
  }
}
