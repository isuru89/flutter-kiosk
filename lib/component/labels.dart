import 'package:flutter/material.dart';

class MainHeader extends StatelessWidget {
  final String? title;
  final bool showUnderline;

  const MainHeader({
    Key? key,
    this.title,
    this.showUnderline = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? "",
          style: Theme.of(context).textTheme.headline2?.copyWith(
                letterSpacing: 3,
                fontWeight: FontWeight.w800,
              ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        if (showUnderline && title != null)
          SizedBox(
            width: 96,
            child: Divider(
              thickness: 6,
              color: theme.primaryColor,
            ),
          )
      ],
    );
  }
}
