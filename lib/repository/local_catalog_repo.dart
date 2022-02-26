import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:kioskflutter/model/catalog.dart';
import 'package:kioskflutter/model/dto/catalog_dto.dart';
import 'package:kioskflutter/model/dto/transformer.dart';
import 'package:kioskflutter/repository/catalog_repo.dart';

class LocalCatalogRepository implements ICatalogRepository {
  final String dataFile;
  _LocalDataHolder? dataHolder;

  LocalCatalogRepository(
    this.dataFile,
  ) {
    dataHolder = _LocalDataHolder(dataFile);
  }

  @override
  Future<List<AddOnGroup>> getAddOnGroups({String? itemId}) async {
    var addOnGroupList = dataHolder!.addOnGroups!;
    var itemList = dataHolder!.items!;

    if (itemId == null) {
      return addOnGroupList;
    } else {
      Item? item = itemList.firstWhereOrNull((it) => it.id == itemId);
      if (item == null) {
        throw Exception("Given item id does not exist!");
      }

      List<AddOnGroup> result = [];
      for (var it in addOnGroupList) {
        if (item.addOnGroupIds.contains(it.id)) {
          result.add(it);
        }
      }
      return result;
    }
  }

  @override
  Future<List<AddOn>> getAddOns({String? itemId}) async {
    var addOnList = dataHolder!.addOns!;
    var addOnGroupList = dataHolder!.addOnGroups!;
    var itemList = dataHolder!.items!;

    if (itemId == null) {
      return addOnList;
    } else {
      Item? item = itemList.firstWhereOrNull((it) => it.id == itemId);
      if (item == null) {
        throw Exception("Given item id does not exist!");
      }

      List<String> addOnIds = [];
      for (var ag in addOnGroupList) {
        if (item.addOnGroupIds.contains(ag.id)) {
          addOnIds.addAll(ag.addOnIds);
        }
      }

      List<AddOn> result = [];
      for (var it in addOnList) {
        if (addOnIds.contains(it.id)) {
          result.add(it);
        }
      }
      return result;
    }
  }

  @override
  Future<List<Category>> getCategories() async {
    await dataHolder?.parse();
    return dataHolder!.categories!;
  }

  @override
  Future<List<Item>> getItems({String? categoryId}) async {
    await dataHolder?.parse();

    var itemList = dataHolder!.items!;
    var categoryList = dataHolder!.categories!;

    if (categoryId == null) {
      return itemList;
    } else {
      Category? cat =
          categoryList.firstWhereOrNull((cat) => cat.id == categoryId);
      if (cat == null) {
        throw Exception("Given category id does not exist!");
      }

      List<Item> items = [];
      for (var it in itemList) {
        if (cat.itemIds.contains(it.id)) {
          items.add(it);
        }
      }
      return items;
    }
  }
}

class _LocalDataHolder {
  final String resourcePath;
  bool _parsed = false;

  FullCatalogDTO? catalog;

  List<Category>? categories;
  List<Item>? items;
  List<AddOnGroup>? addOnGroups;
  List<AddOn>? addOns;

  _LocalDataHolder(this.resourcePath);

  Future<void> parse() async {
    if (_parsed) {
      return;
    }

    categories = null;
    items = null;
    addOnGroups = null;
    addOns = null;

    var dataRaw = await rootBundle.loadString(resourcePath);
    Map<String, dynamic> data = jsonDecode(dataRaw);

    catalog = FullCatalogDTO.fromJson(data);

    categories = catalog!.categories.map((e) => transformCategory(e)).toList();
    items = catalog!.items.map((e) => transformItemDTO(e)).toList();
    addOnGroups =
        catalog!.addOnGroups.map((e) => transformAddOnGroupDTO(e)).toList();
    addOns = catalog!.addOns.map((e) => transformAddOnDTO(e)).toList();

    _parsed = true;
  }
}
