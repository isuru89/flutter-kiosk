import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kioskflutter/blocs/cart/cart_bloc.dart';
import 'package:kioskflutter/blocs/cart/cart_event.dart';
import 'package:kioskflutter/blocs/cart/cart_state.dart';
import 'package:kioskflutter/blocs/catalog/catalog_bloc.dart';
import 'package:kioskflutter/component/button.dart';
import 'package:kioskflutter/component/image_entity.dart';
import 'package:kioskflutter/component/panels.dart';
import 'package:kioskflutter/component/quantity.dart';
import 'package:kioskflutter/feature_flags.dart';
import 'package:kioskflutter/lang_constants.dart';
import 'package:kioskflutter/model/cart.dart';

class CartViewContainer extends StatelessWidget {
  const CartViewContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartBloc bloc = BlocProvider.of<CartBloc>(context);
    return BlocBuilder<CartBloc, CartState>(
      bloc: bloc,
      builder: (ctx, state) => CartView(
        cartItems: state.items,
        total: state.total,
      ),
    );
  }
}

class CartView extends StatelessWidget {
  final List<CartItem> cartItems;
  final double total;

  final ScrollController _cartCtrl = ScrollController();

  CartView({Key? key, required this.cartItems, required this.total})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    if (cartItems.isEmpty) {
      return const CenteredPanel(
        message: "No items in the cart!",
      );
    }

    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            offset: const Offset(-2, 0),
            color: theme.dividerColor,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: theme.canvasColor,
              boxShadow: [
                BoxShadow(
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                  color: theme.dividerColor,
                  spreadRadius: 0,
                )
              ],
            ),
            child: SafeArea(
              top: true,
              bottom: false,
              child: Container(
                color: theme.canvasColor,
                padding: const EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: 24,
                  bottom: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          "$klCartViewMyCartHeaderLabel ",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: theme.primaryColor.withOpacity(0.2),
                          ),
                          child: Center(
                            child: Text(
                              "${cartItems.length}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  ?.copyWith(
                                    color: theme.primaryColor,
                                    fontSize: 16,
                                  ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _cartCtrl,
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: cartItems
                    .map((e) => _buildCartItem(context, theme, e))
                    .toList()
                  ..add(
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Divider(),
                    ),
                  ),
              ),
            ),
          ),
          SafeArea(
            bottom: true,
            top: false,
            left: false,
            right: false,
            child: SizedBox(
              height: 120,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        color: theme.canvasColor,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            offset: const Offset(0, -2),
                            color: theme.dividerColor,
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            klCartViewTotal,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(fontSize: 20),
                          ),
                          PriceLabel(
                            price: total,
                            textStyle: theme.textTheme.headline4
                                ?.copyWith(color: theme.primaryColor),
                            priceTextStyle: theme.textTheme.headline4?.copyWith(
                              color: theme.primaryColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  KioskButton(
                    text: klCartViewCheckout,
                    height: 60,
                    onClicked: () {
                      Navigator.pushNamed(context, '/review');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(
    BuildContext context,
    ThemeData theme,
    CartItem cartItem,
  ) {
    return Padding(
      key: Key(cartItem.lineItemId!),
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 24.0,
      ),
      child: SizedBox(
        height: 200,
        width: 200,
        child: Dismissible(
          key: Key("ci-${cartItem.lineItemId!}"),
          child: MyCartItem(cartItem: cartItem),
          background: Container(
            color: theme.errorColor,
            child: Center(
              child: Text(
                "Removing",
                style: theme.textTheme.bodyText2,
              ),
            ),
          ),
          onDismissed: (direction) {
            context.read<CartBloc>().itemModifiedEvent(
                  CartItemModificationEvent.fromCartItem(
                    cartItem,
                    CartItemModificationType.removed,
                  ),
                );
            if (cartItems.length == 1) {
              Navigator.pop(context);
            }
          },
        ),
      ),
    );
  }
}

class MyCartItem extends StatelessWidget {
  final CartItem cartItem;

  const MyCartItem({Key? key, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          var bloc = context.read<CatalogBloc>();
          await bloc.loadAddOnsOfItem(itemId: cartItem.itemRef.id);
          bloc.selectActiveCartItem(cartItem);
          Navigator.pushNamed(context, "/item");
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 120,
              child: ItemInCart(
                imageUrl: cartItem.itemRef.imageUrl,
                label: cartItem.itemRef.name,
                width: 120,
                height: 120,
                price: cartItem.getItemSubTotal(),
                circular: kCircularItemImages,
              ),
            ),
            Expanded(
              child: Quantity(
                qtyAxis: Axis.vertical,
                qty: cartItem.quantity,
                onIncrease: () {
                  context.read<CartBloc>().itemQuantityChanged(
                        CartItemQuantityChangeEvent(
                          cartItem,
                          cartItem.lineItemId!,
                          1,
                          QuantityChangeType.increment,
                        ),
                      );
                },
                onDecrease: () {
                  context.read<CartBloc>().itemQuantityChanged(
                        CartItemQuantityChangeEvent(
                          cartItem,
                          cartItem.lineItemId!,
                          1,
                          QuantityChangeType.decrement,
                        ),
                      );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
