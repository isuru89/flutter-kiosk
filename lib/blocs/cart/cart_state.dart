import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

import 'package:kioskflutter/model/cart.dart';
import 'package:kioskflutter/model/items.dart';

var cartInitialState = CartState(
    items: const [], total: 0.0, tax: 0.0, serviceCharge: 0.0, subTotal: 0.0);

class CartState extends Equatable {
  final List<CartItem> items;
  final double subTotal;
  final double total;
  final double tax;
  final double serviceCharge;

  CartState({
    required this.items,
    required this.total,
    required this.tax,
    required this.serviceCharge,
    required this.subTotal,
  });

  CartState copyWith({
    List<CartItem>? items,
    double? tax,
    double? serviceCharge,
  }) {
    var allItems = items ?? this.items;
    var rTax = tax ?? this.tax;
    var rServiceCharge = serviceCharge ?? this.serviceCharge;
    var subTotal = 0.0;
    var total = 0.0;

    if (allItems.isEmpty) {}

    for (var element in allItems) {
      subTotal += (element.itemRef.price + element.getTotalAddOnPrice()) *
          element.quantity;
    }
    total = subTotal + rTax + rServiceCharge;

    return CartState(
      items: allItems,
      total: total,
      tax: rTax,
      serviceCharge: rServiceCharge,
      subTotal: subTotal,
    );
  }

  @override
  String toString() {
    return 'CartState(items: $items, total: $total, tax: $tax, serviceCharge: $serviceCharge)';
  }

  @override
  List<Object?> get props => [items, total, tax, serviceCharge];
}
