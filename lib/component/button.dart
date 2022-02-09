import 'package:flutter/material.dart';

class KioskButton extends StatelessWidget {
  final String text;
  final double height;
  final Function() onClicked;
  final bool inactive;
  final Color? activeColor;
  final Color? activeTextColor;
  final Color? inactiveColor;
  final Color? inactiveTextColor;
  final double fontSize;
  final Widget? content;

  const KioskButton(
      {Key? key,
      required this.text,
      this.height = 60,
      required this.onClicked,
      this.inactive = false,
      this.inactiveColor,
      this.inactiveTextColor,
      this.activeColor,
      this.activeTextColor,
      this.fontSize = 20,
      this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
          style: inactive
              ? ElevatedButton.styleFrom(
                  primary: inactiveColor?.withOpacity(0.5),
                  onPrimary: inactiveTextColor?.withOpacity(0.5))
              : ElevatedButton.styleFrom(
                  primary: activeColor, onPrimary: activeTextColor),
          onPressed: onClicked,
          child: content ??
              Text(
                text,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                    fontSize: fontSize),
              )),
    );
  }
}
