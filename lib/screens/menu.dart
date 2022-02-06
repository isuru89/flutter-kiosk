import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kioskflutter/blocs/cart/cart_bloc.dart';
import 'package:kioskflutter/component/button.dart';
import 'package:kioskflutter/model/items.dart';
import 'package:kioskflutter/screens/menu.dart';
import 'package:kioskflutter/views/cart_view.dart';
import 'package:kioskflutter/views/category_list.dart';
import 'package:kioskflutter/views/featured_items.dart';
import 'package:kioskflutter/views/item_view.dart';

class MenuPage2 extends StatelessWidget {
  const MenuPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Flexible(flex: 1, child: CategoryListContainer()),
      Expanded(flex: 3, child: ItemViewContainer()),
      Flexible(flex: 1, fit: FlexFit.loose, child: CartViewContainer()),
    ]);
  }
}
