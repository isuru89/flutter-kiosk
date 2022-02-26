import 'package:json_annotation/json_annotation.dart';

part 'catalog_dto.g.dart';

@JsonSerializable()
class FullCatalogDTO {
  final List<CategoryDTO> categories;
  final List<ItemDTO> items;
  final List<AddOnGroupDTO> addOnGroups;
  final List<AddOnDTO> addOns;

  FullCatalogDTO(this.categories, this.items, this.addOnGroups, this.addOns);

  factory FullCatalogDTO.fromJson(Map<String, dynamic> json) =>
      _$FullCatalogDTOFromJson(json);

  Map<String, dynamic> toJson() => _$FullCatalogDTOToJson(this);
}

@JsonSerializable()
class CategoryDTO {
  CategoryDTO(
    this.id,
    this.name,
    this.imageUrl,
    this.itemIds,
  );

  String id, name;
  String imageUrl;
  List<String> itemIds;

  factory CategoryDTO.fromJson(Map<String, dynamic> json) =>
      _$CategoryDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDTOToJson(this);
}

@JsonSerializable()
class ItemDTO {
  ItemDTO(
    this.id,
    this.name,
    this.basePrice,
    this.imageUrl, {
    this.description = '',
    this.addOnGroupIds = const [],
    this.availableStockCount = 100,
    this.tax,
    this.discount,
    this.attributes = const {},
  });

  String id, name, imageUrl, description;
  double basePrice;
  Map<String, dynamic> attributes;
  List<String> addOnGroupIds;
  int availableStockCount;
  ChargeableDTO? tax;
  ChargeableDTO? discount;

  factory ItemDTO.fromJson(Map<String, dynamic> json) =>
      _$ItemDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ItemDTOToJson(this);
}

@JsonSerializable()
class AddOnGroupDTO {
  String id, name;
  int min, max;
  List<String> addOnIds;

  AddOnGroupDTO(
    this.id,
    this.name, {
    this.min = 0,
    this.max = 0,
    this.addOnIds = const [],
  });

  factory AddOnGroupDTO.fromJson(Map<String, dynamic> json) =>
      _$AddOnGroupDTOFromJson(json);

  Map<String, dynamic> toJson() => _$AddOnGroupDTOToJson(this);
}

@JsonSerializable()
class AddOnDTO {
  AddOnDTO(
    this.id,
    this.name, {
    this.price,
    this.description,
  });

  String id, name;
  String? description;
  String? imageUrl;
  double? price;

  factory AddOnDTO.fromJson(Map<String, dynamic> json) =>
      _$AddOnDTOFromJson(json);

  Map<String, dynamic> toJson() => _$AddOnDTOToJson(this);
}

@JsonSerializable()
class ChargeableDTO {
  String quantityFor;
  String type;
  double amount;

  ChargeableDTO(
    this.type,
    this.amount,
    this.quantityFor,
  );

  factory ChargeableDTO.fromJson(Map<String, dynamic> json) =>
      _$ChargeableDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ChargeableDTOToJson(this);
}
