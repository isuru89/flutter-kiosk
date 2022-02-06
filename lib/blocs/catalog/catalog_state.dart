import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:kioskflutter/model/catalog.dart';
import 'package:kioskflutter/model/items.dart';

var initialCatalogState = CatalogState(
    selectedCategoryId: '',
    featuredItems: const [],
    categories: {for (Category c in normalCategories) c.id: c},
    items: {for (Item it in normalItems) it.id: it},
    addOnGroups: {for (AddOnGroup g in allAddOnGroups) g.id: g},
    addOns: {for (AddOn a in allAddOns) a.id: a},
    selectedItemId: '',
    selectedItemsInCategory: const []);

class CatalogState extends Equatable {
  final String selectedCategoryId;
  final String selectedItemId;
  final List<Item> featuredItems;
  final List<Item> selectedItemsInCategory;
  final Map<String, Category> categories;
  final Map<String, Item> items;
  final Map<String, AddOnGroup> addOnGroups;
  final Map<String, AddOn> addOns;

  CatalogState({
    required this.selectedCategoryId,
    required this.selectedItemId,
    required this.featuredItems,
    required this.selectedItemsInCategory,
    required this.categories,
    required this.items,
    required this.addOnGroups,
    required this.addOns,
  });

  @override
  List<Object> get props {
    return [
      selectedCategoryId,
      selectedItemId,
      featuredItems,
      selectedItemsInCategory,
      categories,
      items,
      addOnGroups,
      addOns,
    ];
  }

  CatalogState copyWith({
    String? selectedCategoryId,
    String? selectedItemId,
    List<Item>? featuredItems,
    List<Item>? selectedItemsInCategory,
    Map<String, Category>? categories,
    Map<String, Item>? items,
    Map<String, AddOnGroup>? addOnGroups,
    Map<String, AddOn>? addOns,
  }) {
    return CatalogState(
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      selectedItemId: selectedItemId ?? this.selectedItemId,
      featuredItems: featuredItems ?? this.featuredItems,
      selectedItemsInCategory:
          selectedItemsInCategory ?? this.selectedItemsInCategory,
      categories: categories ?? this.categories,
      items: items ?? this.items,
      addOnGroups: addOnGroups ?? this.addOnGroups,
      addOns: addOns ?? this.addOns,
    );
  }

  @override
  String toString() {
    return 'CatalogState(selectedCategoryId: $selectedCategoryId, selectedItemId: $selectedItemId, featuredItems: $featuredItems, selectedItemsInCategory: $selectedItemsInCategory, categories: $categories, items: $items, addOnGroups: $addOnGroups, addOns: $addOns)';
  }
}
