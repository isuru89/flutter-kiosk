import 'package:kioskflutter/model/catalog.dart';

abstract class ICatalogRepository {
  Future<List<Category>> getCategories();

  Future<List<Item>> getItems({String? categoryId});

  Future<List<AddOnGroup>> getAddOnGroups({String? itemId});

  Future<List<AddOn>> getAddOns({String? itemId});
}
