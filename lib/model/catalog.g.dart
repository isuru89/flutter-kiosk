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
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'description': instance.description,
      'price': instance.price,
      'addOnGroupIds': instance.addOnGroupIds,
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
