import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kioskflutter/blocs/cart/cart_bloc.dart';
import 'package:kioskflutter/blocs/cart/cart_state.dart';
import 'package:kioskflutter/views/cart_view.dart';
import 'package:kioskflutter/views/category_list.dart';
import 'package:kioskflutter/views/item_view.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) => _MenuPage2(showCart: state.items.isNotEmpty),
    );
  }
}

class _MenuPage2 extends StatelessWidget {
  final bool showCart;

  const _MenuPage2({Key? key, required this.showCart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (showCart) {
      return Row(
        children: const [
          Flexible(flex: 1, child: CategoryListContainer()),
          Expanded(flex: 3, child: ItemViewContainer()),
          Flexible(flex: 1, child: CartViewContainer()),
        ],
      );
    } else {
      return Row(
        children: const [
          Flexible(flex: 1, child: CategoryListContainer()),
          Expanded(flex: 4, child: ItemViewContainer()),
        ],
      );
    }
  }
}
