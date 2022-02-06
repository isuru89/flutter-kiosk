import 'package:equatable/equatable.dart';

import 'catalog.dart';

// ignore: must_be_immutable
class CartItem extends Equatable {
  final Item itemRef;
  final Map<String, List<SelectedAddOn>> addOns;
  int quantity;

  CartItem(this.itemRef, this.quantity, {this.addOns = const {}});

  CartItem copyWith({
    Item? itemRef,
    int? quantity,
    Map<String, List<SelectedAddOn>>? addOns,
  }) {
    return CartItem(
      itemRef ?? this.itemRef,
      quantity ?? this.quantity,
      addOns: addOns ?? this.addOns,
    );
  }

  double getItemSubTotal() {
    return (itemRef.price + getTotalAddOnPrice()) * quantity;
  }

  double getTotalAddOnPrice() {
    if (addOns.isEmpty) {
      return 0.0;
    }

    double total = 0.0;
    for (var element in addOns.values) {
      if (element.isNotEmpty) {
        for (SelectedAddOn a in element) {
          total += a.unitPrice;
        }
      }
    }
    return total;
  }

  @override
  String toString() =>
      'CartItem(itemRef: $itemRef, quantity: $quantity, addOns: $addOns)';

  @override
  List<Object?> get props => [itemRef, addOns, quantity];
}

class SelectedAddOn extends Equatable {
  final AddOn addOnRef;
  final double unitPrice;

  SelectedAddOn({
    required this.addOnRef,
    this.unitPrice = 0,
  });

  @override
  List<Object> get props => [addOnRef];

  SelectedAddOn copyWith({
    AddOn? addOnRef,
    double? unitPrice,
  }) {
    return SelectedAddOn(
      addOnRef: addOnRef ?? this.addOnRef,
      unitPrice: unitPrice ?? this.unitPrice,
    );
  }

  @override
  String toString() =>
      'SelectedAddOn(addOnRef: $addOnRef, unitPrice: $unitPrice)';
}
