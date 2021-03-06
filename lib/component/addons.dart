import 'package:flutter/material.dart';
import 'package:kioskflutter/component/image_entity.dart';
import 'package:kioskflutter/feature_flags.dart';
import 'package:kioskflutter/model/catalog.dart';

class AddOnChip extends StatelessWidget {
  final String addOnName;
  final String id;
  final Function(String) onRemoved;
  final String? prefix;

  const AddOnChip({
    Key? key,
    required this.addOnName,
    required this.id,
    required this.onRemoved,
    this.prefix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "${prefix ?? ''}$addOnName",
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ],
    );
  }
}

class AddOnOption extends StatelessWidget {
  final AddOn addOn;
  final bool isSelected;
  final bool isDisabled;
  final Function(String, bool)? onClicked;

  const AddOnOption({
    Key? key,
    required this.addOn,
    this.isSelected = false,
    this.onClicked,
    this.isDisabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return GestureDetector(
      onTap: !isSelected && isDisabled
          ? null
          : (onClicked != null
              ? () => onClicked!(addOn.id, !isSelected)
              : null),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 400),
        opacity: !isSelected && isDisabled ? 0.5 : 1,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          padding: const EdgeInsets.symmetric(horizontal: 4),
          constraints:
              const BoxConstraints(minWidth: 120, maxWidth: 120, minHeight: 80),
          decoration: BoxDecoration(
            color: isSelected
                ? theme.primaryColor.withOpacity(0.1)
                : Colors.transparent,
            border: isSelected ? Border.all(color: theme.primaryColor) : null,
            borderRadius: BorderRadius.circular(4),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: const Offset(0, 0),
                    )
                  ]
                : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  addOn.name.toUpperCase(),
                  style: theme.textTheme.bodyText1?.copyWith(
                    fontSize: 16,
                    color: isSelected ? theme.primaryColor : null,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              if (addOn.imageUrl != null) ...[
                GrayScaleImage(
                  doGrayScale: !isSelected && isDisabled,
                  child: ItemImage(
                    imageUrl: addOn.imageUrl ?? "https://picsum.photos/100/100",
                    width: 100,
                    height: 100,
                    circular: kCircularItemImages,
                  ),
                )
              ],
              if (addOn.price != null) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    "\$${addOn.price?.toStringAsFixed(2)}",
                    style: theme.textTheme.subtitle2?.copyWith(
                      color: isSelected ? theme.primaryColor : null,
                    ),
                  ),
                )
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class AddOnTitle extends StatelessWidget {
  final String addOnGroupTitle;
  final String? subTitle;
  final bool? allGood;

  const AddOnTitle({
    Key? key,
    required this.addOnGroupTitle,
    this.subTitle,
    this.allGood,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              addOnGroupTitle.toUpperCase(),
              style: theme.textTheme.headline3?.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
            ),
            AllGoodStatus(
              allGood: allGood,
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Divider(),
              ),
            )
          ],
        ),
        if (subTitle != null) ...[
          Text(
            subTitle!,
            style: theme.textTheme.subtitle2
                ?.copyWith(fontWeight: FontWeight.w400),
          )
        ]
      ],
    );
  }
}

class AllGoodStatus extends StatelessWidget {
  final bool? allGood;
  const AllGoodStatus({Key? key, this.allGood}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    if (allGood == null) {
      return Container();
    } else if (allGood!) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Icon(
          Icons.check_circle,
          color: theme.primaryColor,
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Icon(
          Icons.warning,
          color: theme.errorColor,
        ),
      );
    }
  }
}
