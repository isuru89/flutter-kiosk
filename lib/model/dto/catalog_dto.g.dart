// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryDTO _$CategoryDTOFromJson(Map<String, dynamic> json) => CategoryDTO(
      json['id'] as String,
      json['name'] as String,
      json['imageUrl'] as String,
      (json['itemIds'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CategoryDTOToJson(CategoryDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'itemIds': instance.itemIds,
    };

ItemDTO _$ItemDTOFromJson(Map<String, dynamic> json) => ItemDTO(
      json['id'] as String,
      json['name'] as String,
      (json['basePrice'] as num).toDouble(),
      json['imageUrl'] as String,
      description: json['description'] as String? ?? '',
      addOnGroupIds: (json['addOnGroupIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      availableStockCount: json['availableStockCount'] as int? ?? 100,
      tax: json['tax'] == null
          ? null
          : ChargeableDTO.fromJson(json['tax'] as Map<String, dynamic>),
      discount: json['discount'] == null
          ? null
          : ChargeableDTO.fromJson(json['discount'] as Map<String, dynamic>),
      attributes: json['attributes'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$ItemDTOToJson(ItemDTO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'description': instance.description,
      'basePrice': instance.basePrice,
      'attributes': instance.attributes,
      'addOnGroupIds': instance.addOnGroupIds,
      'availableStockCount': instance.availableStockCount,
      'tax': instance.tax,
      'discount': instance.discount,
    };

AddOnGroupDTO _$AddOnGroupDTOFromJson(Map<String, dynamic> json) =>
    AddOnGroupDTO(
      json['id'] as String,
      json['name'] as String,
      min: json['min'] as int? ?? 0,
      max: json['max'] as int? ?? 0,
      addOnIds: (json['addOnIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$AddOnGroupDTOToJson(AddOnGroupDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'min': instance.min,
      'max': instance.max,
      'addOnIds': instance.addOnIds,
    };

AddOnDTO _$AddOnDTOFromJson(Map<String, dynamic> json) => AddOnDTO(
      json['id'] as String,
      json['name'] as String,
      price: (json['price'] as num?)?.toDouble(),
      description: json['description'] as String?,
    )..imageUrl = json['imageUrl'] as String?;

Map<String, dynamic> _$AddOnDTOToJson(AddOnDTO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'price': instance.price,
    };

ChargeableDTO _$ChargeableDTOFromJson(Map<String, dynamic> json) =>
    ChargeableDTO(
      json['type'] as String,
      (json['amount'] as num).toDouble(),
      json['quantityFor'] as String,
    );

Map<String, dynamic> _$ChargeableDTOToJson(ChargeableDTO instance) =>
    <String, dynamic>{
      'quantityFor': instance.quantityFor,
      'type': instance.type,
      'amount': instance.amount,
    };
