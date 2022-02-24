import 'package:equatable/equatable.dart';

import 'package:kioskflutter/model/catalog.dart';

enum CatalogStatusType {
  loading,
  success,
  error,
}

class CatalogStatus extends Equatable {
  final CatalogStatusType status;
  final String? error;
  final bool partially;

  const CatalogStatus(this.status, this.error, {this.partially = false});

  factory CatalogStatus.success({bool partially = false}) {
    return CatalogStatus(CatalogStatusType.success, null, partially: partially);
  }

  factory CatalogStatus.error(String errorMessage) {
    return CatalogStatus(CatalogStatusType.error, errorMessage);
  }

  factory CatalogStatus.loading() {
    return const CatalogStatus(CatalogStatusType.loading, null);
  }

  @override
  List<Object?> get props => [status, error];
}

class CatalogState extends Equatable {
  final CatalogStatus status;

  final String selectedCategoryId;
  final String selectedItemId;
  final String selectedCartItemId;
  final List<Item> featuredItems;
  final List<Item> selectedItemsInCategory;
  final Map<String, Category> categories;
  final Map<String, Item> items;
  final Map<String, AddOnGroup> addOnGroups;
  final Map<String, AddOn> addOns;

  const CatalogState({
    required this.selectedCategoryId,
    required this.selectedItemId,
    required this.selectedCartItemId,
    required this.featuredItems,
    required this.selectedItemsInCategory,
    required this.categories,
    required this.items,
    required this.addOnGroups,
    required this.addOns,
    required this.status,
  });

  @override
  List<Object> get props {
    return [
      selectedCategoryId,
      selectedItemId,
      selectedCartItemId,
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
    String? selectedCartItemId,
    List<Item>? featuredItems,
    List<Item>? selectedItemsInCategory,
    Map<String, Category>? categories,
    Map<String, Item>? items,
    Map<String, AddOnGroup>? addOnGroups,
    Map<String, AddOn>? addOns,
    CatalogStatus? status,
  }) {
    return CatalogState(
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      selectedItemId: selectedItemId ?? this.selectedItemId,
      selectedCartItemId: selectedCartItemId ?? this.selectedCartItemId,
      featuredItems: featuredItems ?? this.featuredItems,
      selectedItemsInCategory:
          selectedItemsInCategory ?? this.selectedItemsInCategory,
      categories: categories ?? this.categories,
      items: items ?? this.items,
      addOnGroups: addOnGroups ?? this.addOnGroups,
      addOns: addOns ?? this.addOns,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'CatalogState(selectedCategoryId: $selectedCategoryId, selectedItemId: $selectedItemId, selectedCartItemId: $selectedCartItemId, featuredItems: $featuredItems, selectedItemsInCategory: $selectedItemsInCategory, categories: $categories, items: $items, addOnGroups: $addOnGroups, addOns: $addOns)';
  }
}

const _loadingCatalogStatus = CatalogStatus(CatalogStatusType.loading, null);

class CatalogLoadingState extends CatalogState {
  const CatalogLoadingState()
      : super(
          selectedCartItemId: '',
          selectedCategoryId: '',
          selectedItemId: '',
          selectedItemsInCategory: const [],
          featuredItems: const [],
          categories: const {},
          items: const {},
          addOns: const {},
          addOnGroups: const {},
          status: _loadingCatalogStatus,
        );
}
