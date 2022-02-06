import 'package:equatable/equatable.dart';
import 'package:kioskflutter/model/cart.dart';
import 'package:kioskflutter/model/catalog.dart';

abstract class CartEvent extends Equatable {}

class CartClearEvent extends CartEvent {
  @override
  List<Object?> get props => [];
}

class CartItemEvent extends CartEvent {
  final Item refItem;

  CartItemEvent(this.refItem);

  @override
  List<Object?> get props => [refItem];
}

class CartItemModificationEvent extends CartItemEvent {
  final CartItemModificationType type;
  final int quantity;
  final CartItem? cartItem;

  CartItemModificationEvent(Item refItem, this.type, this.quantity,
      {this.cartItem})
      : super(refItem);

  factory CartItemModificationEvent.fromCartItem(
      CartItem cartItem, CartItemModificationType type) {
    return CartItemModificationEvent(cartItem.itemRef, type, cartItem.quantity,
        cartItem: cartItem);
  }

  @override
  List<Object?> get props => [refItem, type, quantity];
}

class CartItemQuantityChangeEvent extends CartItemEvent {
  final int amount;
  final QuantityChangeType changeType;

  CartItemQuantityChangeEvent(Item refItem, this.amount, this.changeType)
      : super(refItem);

  @override
  List<Object?> get props => [refItem, amount, changeType];
}

enum CartItemModificationType { added, removed }

enum QuantityChangeType { increment, decrement }
