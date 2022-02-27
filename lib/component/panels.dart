import 'package:flutter/material.dart';

class ThemeAwareCard extends StatelessWidget {
  final Widget child;

  const ThemeAwareCard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      color: theme.backgroundColor,
      decoration:
          BoxDecoration(border: Border.all(color: const Color(0xFF444c56))),
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

class CenteredPanel extends StatelessWidget {
  final String message;
  final Widget? image;
  final String? subMessage;
  final Color? backgroundColor;

  const CenteredPanel({
    Key? key,
    required this.message,
    this.image,
    this.subMessage,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Center(
      child: Container(
        color: backgroundColor,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (image != null) image!,
            Text(
              message,
              style: theme.textTheme.headline3,
              textAlign: TextAlign.center,
            ),
            if (subMessage != null) ...[
              const SizedBox(
                height: 16,
              ),
              Text(
                subMessage!,
                style: theme.textTheme.bodyText1
                    ?.copyWith(fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              )
            ]
          ],
        ),
      ),
    );
  }
}

class UnavailableContent extends StatelessWidget {
  final bool circular;

  const UnavailableContent({
    Key? key,
    this.circular = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      width: double.infinity,
      color: theme.errorColor,
      padding: circular
          ? const EdgeInsets.only(bottom: 12, top: 8)
          : const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        "Out of stock",
        style: theme.textTheme.bodyText2?.copyWith(
          fontSize: 16,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
