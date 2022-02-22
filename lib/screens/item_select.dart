import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kioskflutter/blocs/cart/cart_bloc.dart';
import 'package:kioskflutter/blocs/cart/cart_event.dart';
import 'package:kioskflutter/blocs/cart/cart_state.dart';
import 'package:kioskflutter/blocs/catalog/catalog_bloc.dart';
import 'package:kioskflutter/blocs/catalog/catalog_state.dart';
import 'package:kioskflutter/model/addonmodel.dart';
import 'package:kioskflutter/model/cart.dart';
import 'package:kioskflutter/model/catalog.dart';
import 'package:kioskflutter/views/addon_panel.dart';
import 'package:kioskflutter/views/item_side_panel.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

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
            cartItem: CartItem(item, 1),
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
                  cartItem: cartItem,
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
  final CartItem cartItem;
  final AddOnGroupViewModel addOnGroupViewModel;

  const ItemSelect({
    Key? key,
    required this.addOnGroupViewModel,
    required this.cartItem,
  }) : super(key: key);

  @override
  State<ItemSelect> createState() => _ItemSelectState();
}

class _ItemSelectState extends State<ItemSelect> {
  CartItem? refCartItem;

  _ItemSelectState();

  @override
  void initState() {
    super.initState();

    refCartItem = widget.cartItem.copyWith();
  }

  void _whenAddOnSelected(AddOnGroup group, String addOnId, bool selected) {
    setState(() {
      refCartItem = refCartItem!
          .copyWith(addOns: widget.addOnGroupViewModel.deriveSelectedAddOns());
    });
  }

  void _whenQuantityChanged(QuantityChangeType type) {
    int quantity = refCartItem!.quantity;
    if (type == QuantityChangeType.increment) {
      quantity += 1;
    } else {
      quantity = max(quantity - 1, 1);
    }
    setState(() {
      refCartItem = refCartItem!.copyWith(quantity: quantity);
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var cartItem = refCartItem!;
    bool hasAddOns = widget.addOnGroupViewModel.addOnGroups.isNotEmpty;

    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Flexible(
            flex: hasAddOns ? 7 : 9,
            child: Container(
              decoration: BoxDecoration(
                color: theme.canvasColor,
                border: Border(right: BorderSide(color: theme.dividerColor)),
              ),
              child: ItemSidePanel(
                cartItem: cartItem,
                addToCartClicked: () {
                  context.read<CartBloc>().itemModifiedEvent(
                        CartItemModificationEvent.fromCartItem(
                          CartItem(
                            cartItem.itemRef,
                            cartItem.quantity,
                            lineItemId: cartItem.lineItemId ?? uuid.v4(),
                            addOns: widget.addOnGroupViewModel
                                .deriveSelectedAddOns(),
                          ),
                          CartItemModificationType.added,
                        ),
                      );
                  Navigator.pop(context);
                },
                cancelClicked: () => Navigator.pop(context),
                onQuantityChanged: _whenQuantityChanged,
              ),
            ),
          ),
          Visibility(
            visible: hasAddOns,
            child: Expanded(
              flex: hasAddOns ? 9 : 7,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: theme.backgroundColor,
                padding: const EdgeInsets.all(24),
                child: AddOnPanel(
                  addOnGroupViewModel: widget.addOnGroupViewModel,
                  onAddOnSelected: _whenAddOnSelected,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
