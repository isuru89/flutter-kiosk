import 'package:flutter/material.dart';

class ItemWithNameAndPrice extends StatelessWidget {
  final double? width;
  final double? height;
  final String label;
  final String price;

  const ItemWithNameAndPrice(
      {Key? key,
      this.width,
      this.height,
      required this.label,
      required this.price})
      : super(key: key);

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
            children: [
              Text(
                (label).toUpperCase(),
                style: theme.textTheme.headline4,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              Text(
                (price).toUpperCase(),
                style: theme.textTheme.headline4,
                textAlign: TextAlign.center,
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
  final String price;

  const ItemInCart(
      {Key? key,
      this.width,
      this.height,
      required this.label,
      required this.price})
      : super(key: key);

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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (label).toUpperCase(),
                style: theme.textTheme.headline5,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
              ),
              Text(
                (price).toUpperCase(),
                style: theme.textTheme.headline5,
                textAlign: TextAlign.left,
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

  CategoryItem(
      {Key? key,
      this.width,
      this.height,
      required this.label,
      this.imageUrl,
      this.isSelected = false})
      : super(key: key);

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
                style: theme.textTheme.headline5?.copyWith(color: color),
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
      imageUrl: imageUrl ?? "https://picsum.photos/$width/$height",
      width: width,
      height: height,
    );
  }
}

class PriceLabel extends StatelessWidget {
  final double price;
  final String currency;

  const PriceLabel({Key? key, required this.price, this.currency = '\$'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$currency ${price.toStringAsFixed(2)}",
      style: Theme.of(context).textTheme.headline4,
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
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      width: width,
      height: height,
    );
  }
}
