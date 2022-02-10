import 'dart:math';

import 'package:collection/collection.dart'; // You have to add this manually, for some reason it cannot be added automatically
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kioskflutter/blocs/cart/cart_event.dart';
import 'package:kioskflutter/blocs/cart/cart_state.dart';
import 'package:kioskflutter/model/cart.dart';
// You have to add this manually, for some reason it cannot be added automatically

class CartBloc extends Cubit<CartState> {
  CartBloc() : super(cartInitialState);

  void itemQuantityChanged(CartItemQuantityChangeEvent event) {
    var items = [...state.items];
    int itemIndex =
        items.indexWhere((element) => element.itemRef.id == event.refItem.id);
    if (itemIndex < 0) {
      return;
    }

    CartItem item = items.removeAt(itemIndex);

    if (event.changeType == QuantityChangeType.increment) {
      item = item.copyWith(quantity: item.quantity + event.amount);
    } else if (event.changeType == QuantityChangeType.decrement) {
      item = item.copyWith(quantity: max(item.quantity - event.amount, 1));
    }
    items.insert(itemIndex, item);
    emit(state.copyWith(items: items));
  }

  void itemModifiedEvent(CartItemModificationEvent event) {
    if (event.type == CartItemModificationType.added) {
      var items = [...state.items];
      CartItem? existingItem;
      if (event.cartItem != null) {
        existingItem = items.firstWhereOrNull(
            (element) => element.itemRef.id == event.cartItem?.itemRef.id);
        if (existingItem != null) {
          _removeInPlace(items, event.cartItem!.itemRef.id);
        }

        items.add(event.cartItem!);
      } else {
        existingItem = items.firstWhereOrNull(
            (element) => element.itemRef.id == event.refItem.id);
        if (existingItem != null) {
          _removeInPlace(items, event.refItem.id);
        }
        items.add(CartItem(event.refItem, event.quantity));
      }
      emit(state.copyWith(items: items));
    } else if (event.type == CartItemModificationType.removed) {
      var items = [...state.items];
      items.removeWhere((element) => element.itemRef.id == event.refItem.id);
      emit(state.copyWith(items: items));
    }
  }

  void _removeInPlace(List<CartItem> items, String id) {
    items.removeWhere((element) => element.itemRef.id == id);
  }
}
