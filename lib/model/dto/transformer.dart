import 'package:kioskflutter/model/catalog.dart';
import 'package:kioskflutter/model/dto/catalog_dto.dart';

Category transformCategory(CategoryDTO categoryDTO) {
  return Category(
    categoryDTO.id,
    categoryDTO.name,
    categoryDTO.imageUrl,
    categoryDTO.itemIds,
  );
}

Item transformItemDTO(ItemDTO itemDTO) {
  var item = Item(
    itemDTO.id,
    itemDTO.name,
    itemDTO.basePrice,
    itemDTO.imageUrl,
  );

  item.addOnGroupIds = itemDTO.addOnGroupIds;
  item.availableStockCount = itemDTO.availableStockCount;
  item.description = itemDTO.description;
  item.discount = transformChargeableDTO(itemDTO.discount);
  item.tax = transformChargeableDTO(itemDTO.tax);
  return item;
}

AddOnGroup transformAddOnGroupDTO(AddOnGroupDTO groupDTO) {
  var grp = AddOnGroup(
    groupDTO.id,
    groupDTO.name,
    addOnIds: groupDTO.addOnIds,
    min: groupDTO.min,
    max: groupDTO.max,
  );

  return grp;
}

AddOn transformAddOnDTO(AddOnDTO addOnDTO) {
  var grp = AddOn(
    addOnDTO.id,
    addOnDTO.name,
    price: addOnDTO.price,
    imageUrl: addOnDTO.imageUrl,
  );

  return grp;
}

Chargeable? transformChargeableDTO(ChargeableDTO? chargeableDTO) {
  if (chargeableDTO == null) {
    return null;
  }

  var type = chargeableDTO.type.isEmpty
      ? ChargeType.fixed
      : ChargeType.values.byName(chargeableDTO.type);
  var qFor = chargeableDTO.quantityFor.isEmpty
      ? QuantityType.unit
      : QuantityType.values.byName(chargeableDTO.quantityFor);
  return Chargeable(
    type,
    chargeableDTO.amount,
    qFor,
  );
}
