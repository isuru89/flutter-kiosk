import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kioskflutter/blocs/cart/cart_bloc.dart';
import 'package:kioskflutter/blocs/cart/cart_event.dart';
import 'package:kioskflutter/blocs/catalog/catalog_bloc.dart';
import 'package:kioskflutter/component/quantity.dart';
import 'package:kioskflutter/model/cart.dart';
import 'package:provider/src/provider.dart';

import 'image_entity.dart';
import 'addons.dart';

class ReviewItem extends StatelessWidget {
  final CartItem cartItem;

  const ReviewItem({Key? key, required this.cartItem}) : super(key: key);

  void _onAddOnRemoved(String id) {}

  @override
  Widget build(BuildContext context) {
    bool hasAddOns = cartItem.addOns.isNotEmpty;
    List<Widget> children = [];
    if (hasAddOns) {
      for (var records in cartItem.addOns.values) {
        for (var rec in records) {
          children.add(
            AddOnChip(
              prefix: "• ",
              addOnName: rec.addOnRef.name,
              id: rec.addOnRef.id,
              onRemoved: _onAddOnRemoved,
            ),
          );
        }
      }
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          _triggerCartItemEdit(context);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: 120,
                  color: Colors.tealAccent,
                  child: ItemImage(
                    imageUrl: cartItem.itemRef.imageUrl,
                    width: 120,
                    height: 120,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (hasAddOns) ...[_buildItemName(context)],
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              _triggerCartItemEdit(context);
                            },
                            child: Container(
                              width: 120,
                              child: hasAddOns
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, top: 8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: children,
                                      ),
                                    )
                                  : _buildItemName(context),
                            ),
                          ),
                        ),
                        Container(
                          height: 100,
                          child: Quantity(
                            qty: cartItem.quantity,
                            onDecrease: () {
                              context.read<CartBloc>().itemQuantityChanged(
                                    CartItemQuantityChangeEvent(
                                      cartItem.itemRef,
                                      1,
                                      QuantityChangeType.decrement,
                                    ),
                                  );
                            },
                            onIncrease: () {
                              context.read<CartBloc>().itemQuantityChanged(
                                    CartItemQuantityChangeEvent(
                                      cartItem.itemRef,
                                      1,
                                      QuantityChangeType.increment,
                                    ),
                                  );
                            },
                          ),
                        ),
                        Container(
                          height: 100,
                          constraints: const BoxConstraints(minWidth: 120),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: PriceLabel(
                              price: cartItem.getItemSubTotal(),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            context.read<CartBloc>().itemModifiedEvent(
                                  CartItemModificationEvent.fromCartItem(
                                    cartItem,
                                    CartItemModificationType.removed,
                                  ),
                                );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Icon(
                              CupertinoIcons.delete_left_fill,
                              size: 32,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _triggerCartItemEdit(BuildContext context) {
    context.read<CatalogBloc>().selectActiveCartItem(cartItem);
    Navigator.pushNamed(context, "/item");
  }

  Widget _buildItemName(context) {
    return GestureDetector(
      onTap: () {
        _triggerCartItemEdit(context);
      },
      child: Text(
        cartItem.itemRef.name.toUpperCase(),
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }
}
