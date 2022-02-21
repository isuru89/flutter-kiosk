import 'package:flutter/material.dart';

class ItemWithNameAndPrice extends StatelessWidget {
  final double? width;
  final double? height;
  final String label;
  final double price;
  final double? prevPrice;
  final String? currency;
  final Widget? subContent;
  final bool circular;

  const ItemWithNameAndPrice({
    Key? key,
    this.width,
    this.height,
    required this.label,
    required this.price,
    this.prevPrice,
    this.currency,
    this.subContent,
    this.circular = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            ItemImage(
              imageUrl: "https://picsum.photos/400/400",
              width: width,
              height: height,
              circular: circular,
            ),
            if (subContent != null) subContent!,
          ],
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                (label).toUpperCase(),
                style: theme.textTheme.headline4?.copyWith(height: 1),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              PriceLabel(
                price: price,
                prevPrice: prevPrice,
                textStyle: theme.textTheme.subtitle2?.copyWith(fontSize: 20),
                priceTextStyle:
                    theme.textTheme.subtitle2?.copyWith(fontSize: 14),
                prevPriceTextStyle:
                    theme.textTheme.subtitle2?.copyWith(fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ItemInCart extends StatelessWidget {
  final double? width;
  final double? height;
  final String label;
  final double price;
  final String? currency;
  final bool circular;

  const ItemInCart({
    Key? key,
    this.width,
    this.height,
    required this.label,
    required this.price,
    this.currency,
    this.circular = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ItemImage(
          imageUrl: "https://picsum.photos/400/400",
          width: width,
          height: height,
          circular: circular,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (label).toUpperCase(),
                style: theme.textTheme.headline5?.copyWith(fontSize: 16),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
              ),
              PriceLabel(
                price: price,
                mainAxisAlignment: MainAxisAlignment.start,
                textStyle: theme.textTheme.subtitle1?.copyWith(fontSize: 16),
                priceTextStyle:
                    theme.textTheme.subtitle1?.copyWith(fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CategoryItem extends StatelessWidget {
  final double? width;
  final double? height;
  final String label;
  final String? imageUrl;
  final bool isSelected;

  const CategoryItem({
    Key? key,
    this.width,
    this.height,
    required this.label,
    this.imageUrl,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var color = isSelected ? theme.primaryColor : null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _categoryImage(),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                (label).toUpperCase(),
                style: theme.textTheme.bodyText1
                    ?.copyWith(color: color, fontSize: 16),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _categoryImage() {
    return ItemImage(
      imageUrl: imageUrl ??
          "https://picsum.photos/${width?.toInt()}/${height?.toInt()}",
      width: width,
      height: height,
    );
  }
}

class PriceLabel extends StatelessWidget {
  final double price;
  final double? prevPrice;
  final String currency;
  final Color? color;
  final TextStyle? textStyle;
  final TextStyle? prevPriceTextStyle;
  final TextStyle? priceTextStyle;
  final MainAxisAlignment? mainAxisAlignment;

  const PriceLabel({
    Key? key,
    required this.price,
    this.prevPrice,
    this.currency = '\$',
    this.color,
    this.textStyle,
    this.priceTextStyle,
    this.prevPriceTextStyle,
    this.mainAxisAlignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool hasPriceDiff = prevPrice != null;
    var decoration =
        hasPriceDiff ? TextDecoration.lineThrough : TextDecoration.none;

    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      textBaseline: TextBaseline.alphabetic,
      children: [
        if (hasPriceDiff)
          Opacity(
            opacity: 0.5,
            child: Row(
              children: [
                Text(
                  currency,
                  style: (prevPriceTextStyle ??
                          priceTextStyle ??
                          textStyle ??
                          theme.textTheme.headline4)
                      ?.copyWith(
                    color: color,
                    fontSize: 16,
                    decoration: decoration,
                  ),
                ),
                Text(
                  prevPrice!.toStringAsFixed(2),
                  style: (prevPriceTextStyle ??
                          textStyle ??
                          theme.textTheme.headline4)
                      ?.copyWith(
                    color: color,
                    decoration: decoration,
                  ),
                ),
                const SizedBox(
                  width: 4,
                )
              ],
            ),
          ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 2),
              child: Text(
                currency,
                style: priceTextStyle ??
                    textStyle ??
                    theme.textTheme.headline4
                        ?.copyWith(color: color, fontSize: 16),
              ),
            ),
            Text(
              price.toStringAsFixed(2),
              style: textStyle ??
                  theme.textTheme.headline4?.copyWith(color: color),
            ),
          ],
        ),
      ],
    );
  }
}

class ItemImage extends StatelessWidget {
  final double? width;
  final double? height;
  final String imageUrl;
  final bool circular;

  const ItemImage({
    Key? key,
    this.width,
    this.height,
    required this.imageUrl,
    this.circular = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Image img;
    if (imageUrl.startsWith("assets/")) {
      img = Image.asset(
        imageUrl,
        fit: BoxFit.cover,
        width: width,
        height: height,
      );
    } else {
      img = Image.network(
        imageUrl,
        fit: BoxFit.cover,
        width: width,
        height: height,
      );
    }

    if (circular) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(500),
        child: img,
      );
    } else {
      return img;
    }
  }
}
