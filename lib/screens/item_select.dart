import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kioskflutter/blocs/cart/cart_bloc.dart';
import 'package:kioskflutter/blocs/cart/cart_event.dart';
import 'package:kioskflutter/blocs/cart/cart_state.dart';
import 'package:kioskflutter/blocs/catalog/catalog_bloc.dart';
import 'package:kioskflutter/blocs/catalog/catalog_state.dart';
import 'package:kioskflutter/constants.dart';
import 'package:kioskflutter/model/addonmodel.dart';
import 'package:kioskflutter/model/cart.dart';
import 'package:kioskflutter/model/catalog.dart';
import 'package:kioskflutter/views/addon_panel.dart';
import 'package:kioskflutter/views/item_side_panel.dart';

class ItemSelectContainer extends StatelessWidget {
  const ItemSelectContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CatalogBloc bloc = BlocProvider.of<CatalogBloc>(context);
    return BlocBuilder<CatalogBloc, CatalogState>(
      bloc: bloc,
      builder: (ctx, state) {
        Item? item = state.items[state.selectedItemId];
        if (item != null) {
          return ItemSelect(
            key: Key(item.id),
            item: item,
            addOnGroupViewModel: AddOnGroupViewModel.fromState(state, item),
          );
        } else {
          return BlocBuilder<CartBloc, CartState>(
            builder: (context, cartState) {
              CartItem? cartItem;
              for (var element in cartState.items) {
                if (element.itemRef.id == state.selectedCartItemId) {
                  cartItem = element;
                  break;
                }
              }

              if (cartItem != null) {
                return ItemSelect(
                  key: Key(cartItem.itemRef.id),
                  item: cartItem.itemRef,
                  addOnGroupViewModel:
                      AddOnGroupViewModel.fromCartItem(state, cartItem),
                );
              } else {
                return const Center(child: Text("Select an Item !"));
              }
            },
          );
        }
      },
    );
  }
}

class ItemSelect extends StatefulWidget {
  final Item item;
  final AddOnGroupViewModel addOnGroupViewModel;

  const ItemSelect({
    Key? key,
    required this.item,
    required this.addOnGroupViewModel,
  }) : super(key: key);

  @override
  State<ItemSelect> createState() => _ItemSelectState(
        addOnGroupViewModel,
        item: item,
      );
}

class _ItemSelectState extends State<ItemSelect> {
  final Item item;
  final AddOnGroupViewModel addOnGroupViewModel;
  int quantity = 1;

  _ItemSelectState(
    this.addOnGroupViewModel, {
    required this.item,
  });

  void _whenQuantityChanged(QuantityChangeType type) {
    if (type == QuantityChangeType.increment) {
      quantity += 1;
    } else {
      quantity = max(quantity - 1, 1);
    }
    setState(() {
      quantity = quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Flexible(
            flex: 7,
            child: Container(
              decoration: BoxDecoration(
                color: theme.shadowColor,
                border: Border(right: BorderSide(color: theme.dividerColor)),
              ),
              child: ItemSidePanel(
                item: item,
                addToCartClicked: () {
                  context.read<CartBloc>().itemModifiedEvent(
                        CartItemModificationEvent.fromCartItem(
                          CartItem(
                            item,
                            quantity,
                            addOns: addOnGroupViewModel.deriveSelectedAddOns(),
                          ),
                          CartItemModificationType.added,
                        ),
                      );
                  Navigator.pop(context);
                },
                cancelClicked: () => Navigator.pop(context),
                quantity: quantity,
                onQuantityChanged: _whenQuantityChanged,
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: theme.backgroundColor,
              padding: const EdgeInsets.all(24),
              child: AddOnPanel(
                addOnGroupViewModel: addOnGroupViewModel,
              ),
            ),
          )
        ],
      ),
    );
  }
}
