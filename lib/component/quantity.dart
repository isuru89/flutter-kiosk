import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kioskflutter/constants.dart';

class Quantity extends StatelessWidget {
  final int qty;
  final Function() onIncrease;
  final Function() onDecrease;
  final Axis qtyAxis;

  const Quantity(
      {Key? key,
      required this.qty,
      required this.onIncrease,
      required this.onDecrease,
      this.qtyAxis = Axis.horizontal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    if (qtyAxis == Axis.vertical) {
      return _qtyOnTop(context, theme);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 4),
          child: Text(
            "QTY",
            style: theme.textTheme.subtitle1,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(onTap: onIncrease, child: const _ChevronUp()),
            Text(
              "$qty",
              style: theme.textTheme.headline4
                  ?.copyWith(color: theme.primaryColor),
            ),
            GestureDetector(onTap: onDecrease, child: const _ChevronDown())
          ],
        )
      ],
    );
  }

  Widget _qtyOnTop(BuildContext context, ThemeData theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
          child: Text(
            "QTY",
            style: theme.textTheme.subtitle1,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(onTap: onIncrease, child: const _ChevronUp()),
            Text(
              "$qty",
              style: theme.textTheme.headline4
                  ?.copyWith(color: theme.primaryColor),
            ),
            GestureDetector(onTap: onDecrease, child: const _ChevronDown())
          ],
        )
      ],
    );
  }
}

class _ChevronUp extends StatelessWidget {
  const _ChevronUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      CupertinoIcons.chevron_up,
      color: Color.fromARGB(255, 128, 128, 128),
    );
  }
}

class _ChevronDown extends StatelessWidget {
  const _ChevronDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      CupertinoIcons.chevron_down,
      color: kSecondaryTextColor,
    );
  }
}
