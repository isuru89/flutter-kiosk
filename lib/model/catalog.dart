import 'package:json_annotation/json_annotation.dart';

part 'catalog.g.dart';

@JsonSerializable()
class Category {
  Category(
    this.id,
    this.name,
    this.imageUrl,
    this.itemIds,
  );

  String id, name;
  String imageUrl;
  List<String> itemIds;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class Item {
  Item(
    this.id,
    this.name,
    this.price,
    this.imageUrl, {
    this.description = '',
    this.addOnGroupIds = const [],
    this.calories,
    this.availableStockCount = 100,
    this.tax,
    this.discount,
  });

  String id, name, imageUrl, description;
  double price;
  int? calories;
  List<String> addOnGroupIds;
  int availableStockCount;
  Chargeable? tax;
  Chargeable? discount;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);

  @override
  String toString() =>
      'Item(id: $id, name: $name, quantity: $imageUrl, price: $price)';
}

@JsonSerializable()
class AddOnGroup {
  AddOnGroup(
    this.id,
    this.name, {
    this.mandatory = false,
    this.min = 0,
    this.max = 0,
    this.addOnIds = const [],
  });

  String id, name;
  bool mandatory;
  int min, max;
  List<String> addOnIds;

  factory AddOnGroup.fromJson(Map<String, dynamic> json) =>
      _$AddOnGroupFromJson(json);

  Map<String, dynamic> toJson() => _$AddOnGroupToJson(this);
}

@JsonSerializable()
class AddOn {
  AddOn(this.id, this.name, {this.price});

  String id, name;
  String? imageUrl;
  double? price;

  factory AddOn.fromJson(Map<String, dynamic> json) => _$AddOnFromJson(json);

  Map<String, dynamic> toJson() => _$AddOnToJson(this);
}

@JsonSerializable()
class Chargeable {
  QuantityType quantityFor;
  ChargeType type;
  double amount;

  Chargeable(this.type, this.amount, this.quantityFor);

  factory Chargeable.fixed(double amount) =>
      Chargeable(ChargeType.fixed, amount, QuantityType.unit);

  factory Chargeable.percentage(double amount) =>
      Chargeable(ChargeType.percentage, amount, QuantityType.unit);

  factory Chargeable.fromJson(Map<String, dynamic> json) =>
      _$ChargeableFromJson(json);

  Map<String, dynamic> toJson() => _$ChargeableToJson(this);
}

enum QuantityType { unit, whole }

enum ChargeType { fixed, percentage }
