import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kioskflutter/blocs/cart/cart_bloc.dart';
import 'package:kioskflutter/blocs/cart/cart_event.dart';
import 'package:kioskflutter/blocs/cart/cart_state.dart';
import 'package:kioskflutter/component/button.dart';
import 'package:kioskflutter/component/image_entity.dart';
import 'package:kioskflutter/component/quantity.dart';
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
            ));
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
    if (cartItems.isEmpty) {
      return Container();
    }

    return Container(
      constraints: const BoxConstraints(maxWidth: 240),
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            blurRadius: 15,
            offset: Offset(-8, 0),
            color: Color(0xFFF0F0F0),
            spreadRadius: 4)
      ]),
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "MY CART (${cartItems.length})",
                  style: Theme.of(context).textTheme.headline3,
                ),
                const Divider()
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
                controller: _cartCtrl,
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: cartItems
                      .map((e) => Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 24.0),
                            child: Container(
                              height: 180,
                              width: 200,
                              child: MyCartItem(cartItem: e),
                            ),
                          ))
                      .toList(),
                )),
          ),
          Container(
            height: 120,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          blurRadius: 15,
                          offset: const Offset(0, -4),
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 4)
                    ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "TOTAL:",
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Text(
                          "\$${total.toStringAsFixed(2)}",
                          style: Theme.of(context).textTheme.headline4,
                        )
                      ],
                    ),
                  ),
                ),
                KioskButton(
                    text: "CHECKOUT",
                    height: 60,
                    onClicked: () {
                      Navigator.pushNamed(context, '/review');
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyCartItem extends StatelessWidget {
  final CartItem cartItem;

  MyCartItem({Key? key, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(cartItem);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 120,
          child: ItemInCart(
              label: cartItem.itemRef.name,
              width: 120,
              height: 120,
              price: "\$${cartItem.getItemSubTotal().toStringAsFixed(2)}"),
        ),
        Quantity(
            qtyAxis: Axis.vertical,
            qty: cartItem.quantity,
            onIncrease: () {
              context.read<CartBloc>().itemQuantityChanged(
                  CartItemQuantityChangeEvent(
                      cartItem.itemRef, 1, QuantityChangeType.increment));
            },
            onDecrease: () {
              context.read<CartBloc>().itemQuantityChanged(
                  CartItemQuantityChangeEvent(
                      cartItem.itemRef, 1, QuantityChangeType.decrement));
            })
      ],
    );
  }
}
