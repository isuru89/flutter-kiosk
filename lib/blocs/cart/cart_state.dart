import 'package:equatable/equatable.dart';

import 'package:kioskflutter/model/cart.dart';
import 'package:kioskflutter/utils/orders.dart';

var cartInitialState = const CartState(
  items: [],
  total: 0.0,
  tax: 0.0,
  serviceCharge: 0.0,
  subTotal: 0.0,
);

class CartState extends Equatable {
  final List<CartItem> items;
  final double subTotal;
  final double total;
  final double tax;
  final double serviceCharge;

  const CartState({
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
    var rServiceCharge = serviceCharge ?? this.serviceCharge;
    var subTotal = 0.0;
    var total = 0.0;
    var rTax = 0.0;

    for (var element in allItems) {
      var itemFinalPrice = calculatePriceAfterDiscount(
        element.itemRef,
        totalBaseAmount: element.itemRef.price + element.getTotalAddOnPrice(),
        quantity: element.quantity,
      );

      subTotal += itemFinalPrice;
      rTax += calculateTax(
            element.itemRef,
            itemFinalPrice,
          ) ??
          0.0;
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
