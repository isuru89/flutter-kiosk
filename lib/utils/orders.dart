import 'package:kioskflutter/model/catalog.dart';

bool isStockAvailable(Item item) {
  return item.availableStockCount > 0;
}

double? calculateTax(Item item, double forAmount) {
  if (item.tax == null) {
    return null;
  }

  var tax = item.tax!;
  if (tax.type == ChargeType.fixed) {
    return tax.amount;
  } else {
    return forAmount * tax.amount;
  }
}

double calculateFinalPrice(Item item, double addOnPrice, int quantity) {
  var priceAfterDiscount = calculatePriceAfterDiscount(
    item,
    totalBaseAmount: item.price + addOnPrice,
    quantity: quantity,
  );
  var taxes = calculateTax(item, priceAfterDiscount);
  if (taxes == null) {
    return priceAfterDiscount;
  } else {
    return taxes;
  }
}

double? calculateOptionalDiscount(Item item) {
  if (item.discount == null) {
    return null;
  }

  var discount = item.discount!;

  if (discount.type == ChargeType.fixed) {
    return (item.price - discount.amount);
  } else {
    return item.price * (1.0 - discount.amount);
  }
}

double calculatePriceAfterDiscount(
  Item item, {
  double? totalBaseAmount,
  int quantity = 1,
}) {
  double price = totalBaseAmount ?? item.price;
  if (item.discount == null) {
    return price * quantity;
  }

  var discount = item.discount!;

  if (discount.type == ChargeType.fixed) {
    if (discount.quantityFor == QuantityType.unit) {
      return (price - discount.amount) * quantity;
    } else {
      return (price * quantity) - discount.amount;
    }
  } else {
    return price * (1.0 - discount.amount) * quantity;
  }
}
