import 'package:flutter/material.dart';

class ItemWithNameAndPrice extends StatelessWidget {
  final double? width;
  final double? height;
  final String label;
  final double price;
  final String? currency;

  const ItemWithNameAndPrice({
    Key? key,
    this.width,
    this.height,
    required this.label,
    required this.price,
    this.currency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ItemImage(
          imageUrl: "https://picsum.photos/400/400",
          width: width,
          height: height,
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
                textStyle: theme.textTheme.subtitle2?.copyWith(fontSize: 20),
                priceTextStyle:
                    theme.textTheme.subtitle2?.copyWith(fontSize: 14),
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

  const ItemInCart({
    Key? key,
    this.width,
    this.height,
    required this.label,
    required this.price,
    this.currency,
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
  final String currency;
  final Color? color;
  final TextStyle? textStyle;
  final TextStyle? priceTextStyle;
  final MainAxisAlignment? mainAxisAlignment;

  const PriceLabel({
    Key? key,
    required this.price,
    this.currency = '\$',
    this.color,
    this.textStyle,
    this.priceTextStyle,
    this.mainAxisAlignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 2),
          child: Text(
            currency,
            style: priceTextStyle ??
                textStyle ??
                Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: color, fontSize: 16),
          ),
        ),
        Text(
          price.toStringAsFixed(2),
          style: textStyle ??
              Theme.of(context).textTheme.headline4?.copyWith(color: color),
        ),
      ],
    );
  }
}

class ItemImage extends StatelessWidget {
  final double? width;
  final double? height;
  final String imageUrl;

  const ItemImage({Key? key, this.width, this.height, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl.startsWith("assets/")) {
      return Image.asset(
        imageUrl,
        fit: BoxFit.cover,
        width: width,
        height: height,
      );
    } else {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        width: width,
        height: height,
      );
    }
  }
}
