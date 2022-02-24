import 'package:collection/collection.dart';
import 'package:kioskflutter/model/catalog.dart';
import 'package:kioskflutter/repository/catalog_repo.dart';

class LocalCatalogRepository implements ICatalogRepository {
  final List<Category> categoryList;
  final List<Item> itemList;
  final List<AddOnGroup> addOnGroupList;
  final List<AddOn> addOnList;

  LocalCatalogRepository(
    this.categoryList,
    this.itemList,
    this.addOnGroupList,
    this.addOnList,
  );

  @override
  Future<List<AddOnGroup>> getAddOnGroups({String? itemId}) async {
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
    return categoryList;
  }

  @override
  Future<List<Item>> getItems({String? categoryId}) async {
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
