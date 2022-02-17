import 'package:badges/badges.dart';
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
    var orientation = MediaQuery.of(context).orientation;
    var theme = Theme.of(context);

    if (orientation == Orientation.landscape) {
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
    } else {
      return Scaffold(
        floatingActionButton: Builder(
          builder: (ctx) {
            return Visibility(
                visible: showCart,
                child: BlocBuilder<CartBloc, CartState>(
                  buildWhen: (previous, current) =>
                      previous.items.length != current.items.length,
                  builder: (blocCtx, state) => SizedBox(
                    width: 64,
                    height: 64,
                    child: FittedBox(
                      child: FloatingActionButton(
                        backgroundColor: theme.primaryColor,
                        child: Badge(
                          badgeColor: theme.errorColor,
                          padding: const EdgeInsets.all(6),
                          position: BadgePosition.topEnd(top: -16),
                          badgeContent: Text(
                            "${state.items.length}",
                            style: theme.textTheme.headline5
                                ?.copyWith(color: Colors.white),
                          ),
                          child: const Icon(
                            Icons.shopping_cart,
                            size: 36,
                          ),
                        ),
                        onPressed: () => Scaffold.of(ctx).openEndDrawer(),
                      ),
                    ),
                  ),
                ));
          },
        ),
        endDrawer: const Drawer(
          child: CartViewContainer(),
        ),
        body: Row(
          children: const [
            Flexible(
              flex: 4,
              child: CategoryListContainer(),
            ),
            Expanded(
              flex: 13,
              child: ItemViewContainer(),
            ),
          ],
        ),
      );
    }
  }
}
