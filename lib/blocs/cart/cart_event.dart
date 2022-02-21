import 'package:equatable/equatable.dart';
import 'package:kioskflutter/model/cart.dart';

abstract class CartEvent extends Equatable {}

class CartClearEvent extends CartEvent {
  @override
  List<Object?> get props => [];
}

class CartItemEvent extends CartEvent {
  final CartItem cartItem;
  final String lineItemId;

  CartItemEvent(this.cartItem, this.lineItemId);

  @override
  List<Object?> get props => [cartItem];
}

class CartItemModificationEvent extends CartItemEvent {
  final CartItemModificationType type;
  final int quantity;

  CartItemModificationEvent(
    CartItem refItem,
    String lineItemId,
    this.type,
    this.quantity,
  ) : super(refItem, lineItemId);

  factory CartItemModificationEvent.fromCartItem(
    CartItem cartItem,
    CartItemModificationType type,
  ) {
    return CartItemModificationEvent(
      cartItem,
      cartItem.lineItemId ?? '',
      type,
      cartItem.quantity,
    );
  }

  @override
  List<Object?> get props => [type, quantity];
}

class CartItemQuantityChangeEvent extends CartItemEvent {
  final int amount;
  final QuantityChangeType changeType;

  CartItemQuantityChangeEvent(
    CartItem refItem,
    String lineItemId,
    this.amount,
    this.changeType,
  ) : super(refItem, lineItemId);

  @override
  List<Object?> get props => [amount, changeType];
}

enum CartItemModificationType { added, removed }

enum QuantityChangeType { increment, decrement }
