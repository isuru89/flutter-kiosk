import 'package:flutter/material.dart';
import 'package:kioskflutter/blocs/cart/cart_event.dart';
import 'package:kioskflutter/component/button.dart';
import 'package:kioskflutter/component/image_entity.dart';
import 'package:kioskflutter/component/quantity.dart';
import 'package:kioskflutter/model/catalog.dart';

import '../constants.dart';

class ItemSidePanel extends StatelessWidget {
  final Item item;
  final int quantity;
  final Function() addToCartClicked;
  final Function() cancelClicked;
  final Function(QuantityChangeType) onQuantityChanged;

  const ItemSidePanel(
      {Key? key,
      required this.item,
      required this.addToCartClicked,
      required this.cancelClicked,
      required this.quantity,
      required this.onQuantityChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ItemImage(
          imageUrl: item.imageUrl,
          width: double.infinity,
          height: 300,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Text(
            item.name.toUpperCase(),
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            item.description,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(height: 1.5),
          ),
        ),
        if (item.calories != null) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Text(
              "${item.calories} Cal",
              style: Theme.of(context).textTheme.subtitle2,
            ),
          )
        ],
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Quantity(
                    qty: quantity,
                    onIncrease: () =>
                        onQuantityChanged(QuantityChangeType.increment),
                    onDecrease: () =>
                        onQuantityChanged(QuantityChangeType.decrement)),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        "TOTAL: ",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            ?.copyWith(color: kSecondaryTextColor),
                      ),
                    ),
                    PriceLabel(
                      price: item.price,
                      color: theme.primaryColor,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  flex: 9,
                  child: KioskButton(
                      text: "ADD TO CART", onClicked: addToCartClicked)),
              Flexible(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: KioskButton(
                    text: "CANCEL",
                    onClicked: cancelClicked,
                    inactive: true,
                    inactiveColor: kSecondaryTextColor,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
