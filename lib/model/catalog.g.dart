// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      json['id'] as String,
      json['name'] as String,
      json['imageUrl'] as String,
      (json['itemIds'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'itemIds': instance.itemIds,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      json['id'] as String,
      json['name'] as String,
      (json['price'] as num).toDouble(),
      json['imageUrl'] as String,
      description: json['description'] as String? ?? '',
      addOnGroupIds: (json['addOnGroupIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      calories: json['calories'] as int?,
      availableStockCount: json['availableStockCount'] as int? ?? 100,
      tax: json['tax'] == null
          ? null
          : Chargeable.fromJson(json['tax'] as Map<String, dynamic>),
      discount: json['discount'] == null
          ? null
          : Chargeable.fromJson(json['discount'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'description': instance.description,
      'price': instance.price,
      'calories': instance.calories,
      'addOnGroupIds': instance.addOnGroupIds,
      'availableStockCount': instance.availableStockCount,
      'tax': instance.tax,
      'discount': instance.discount,
    };

AddOnGroup _$AddOnGroupFromJson(Map<String, dynamic> json) => AddOnGroup(
      json['id'] as String,
      json['name'] as String,
      mandatory: json['mandatory'] as bool? ?? false,
      min: json['min'] as int? ?? 0,
      max: json['max'] as int? ?? 0,
      addOnIds: (json['addOnIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$AddOnGroupToJson(AddOnGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mandatory': instance.mandatory,
      'min': instance.min,
      'max': instance.max,
      'addOnIds': instance.addOnIds,
    };

AddOn _$AddOnFromJson(Map<String, dynamic> json) => AddOn(
      json['id'] as String,
      json['name'] as String,
      price: (json['price'] as num?)?.toDouble(),
    )..imageUrl = json['imageUrl'] as String?;

Map<String, dynamic> _$AddOnToJson(AddOn instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'price': instance.price,
    };

Chargeable _$ChargeableFromJson(Map<String, dynamic> json) => Chargeable(
      $enumDecode(_$ChargeTypeEnumMap, json['type']),
      (json['amount'] as num).toDouble(),
      $enumDecode(_$QuantityTypeEnumMap, json['quantityFor']),
    );

Map<String, dynamic> _$ChargeableToJson(Chargeable instance) =>
    <String, dynamic>{
      'quantityFor': _$QuantityTypeEnumMap[instance.quantityFor],
      'type': _$ChargeTypeEnumMap[instance.type],
      'amount': instance.amount,
    };

const _$ChargeTypeEnumMap = {
  ChargeType.fixed: 'fixed',
  ChargeType.percentage: 'percentage',
};

const _$QuantityTypeEnumMap = {
  QuantityType.unit: 'unit',
  QuantityType.whole: 'whole',
};
