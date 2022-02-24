import 'package:bloc/bloc.dart';
import 'package:kioskflutter/blocs/catalog/catalog_state.dart';
import 'package:kioskflutter/model/cart.dart';
import 'package:kioskflutter/model/catalog.dart';
import 'package:kioskflutter/repository/catalog_repo.dart';

const loadingCatalog = CatalogLoadingState();
var initialEmptyCatalog =
    loadingCatalog.copyWith(status: CatalogStatus.success());

class CatalogBloc extends Cubit<CatalogState> {
  CatalogBloc(this.catalogRepository) : super(initialEmptyCatalog);

  final ICatalogRepository catalogRepository;

  Future<void> loadCategories() async {
    try {
      emit(loadingCatalog);

      final categories = await catalogRepository.getCategories();
      emit(
        state.copyWith(
          categories: {for (var cat in categories) cat.id: cat},
          status: CatalogStatus.success(),
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: CatalogStatus.error("Error while loading categories!"),
        ),
      );
    }
  }

  Future<void> loadItems({String? categoryId}) async {
    try {
      emit(state.copyWith(status: CatalogStatus.loading()));

      List<Item> items;
      List<AddOnGroup> addOnGroups;
      List<AddOn> addOns;
      if (categoryId == null) {
        items = await catalogRepository.getItems();
        addOnGroups = await catalogRepository.getAddOnGroups();
        addOns = await catalogRepository.getAddOns();
      } else {
        items = await catalogRepository.getItems(categoryId: categoryId);
        addOns = [];
        addOnGroups = [];
      }

      emit(
        state.copyWith(
          items: {for (var it in items) it.id: it},
          addOnGroups: {for (var ad in addOnGroups) ad.id: ad},
          addOns: {for (var ad in addOns) ad.id: ad},
          status: CatalogStatus.success(partially: categoryId != null),
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: CatalogStatus.error(
            "Error while loading items for category $categoryId!",
          ),
        ),
      );
    }
  }

  Future<void> loadAddOnsOfItem({String? itemId}) async {
    try {
      emit(state.copyWith(status: CatalogStatus.loading()));

      List<AddOnGroup> addOnGroups;
      List<AddOn> addOns;
      if (itemId == null) {
        addOnGroups = await catalogRepository.getAddOnGroups();
        addOns = await catalogRepository.getAddOns();
      } else {
        addOnGroups = await catalogRepository.getAddOnGroups(itemId: itemId);
        addOns = await catalogRepository.getAddOns(itemId: itemId);
      }

      emit(
        state.copyWith(
          addOnGroups: {for (var ad in addOnGroups) ad.id: ad},
          addOns: {for (var ad in addOns) ad.id: ad},
          status: CatalogStatus.success(partially: itemId != null),
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: CatalogStatus.error(
              "Error while loading add-ons for item $itemId!"),
        ),
      );
    }
  }

  void selectActiveCategory(String categoryId) {
    Category? category = state.categories[categoryId];
    if (category == null) {
      // no category found
      return;
    }

    List<Item> selectedItems = [];
    for (var i = 0; i < category.itemIds.length; i++) {
      Item? it = state.items[category.itemIds[i]];
      if (it != null) {
        selectedItems.add(it);
      }
    }
    emit(
      state.copyWith(
        selectedCategoryId: categoryId,
        selectedItemsInCategory: selectedItems,
      ),
    );
  }

  void selectActiveItem(String itemId) {
    emit(state.copyWith(selectedItemId: itemId, selectedCartItemId: ''));
  }

  void selectActiveCartItem(CartItem cartItem) {
    emit(
      state.copyWith(
        selectedCartItemId: cartItem.itemRef.id,
        selectedItemId: '',
      ),
    );
  }
}
