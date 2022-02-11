import 'package:bloc/bloc.dart';
import 'package:kioskflutter/blocs/catalog/catalog_state.dart';
import 'package:kioskflutter/model/cart.dart';
import 'package:kioskflutter/model/catalog.dart';

class CatalogBloc extends Cubit<CatalogState> {
  CatalogBloc() : super(initialCatalogState);

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
    emit(state.copyWith(
        selectedCategoryId: categoryId,
        selectedItemsInCategory: selectedItems));
  }

  void selectActiveItem(String itemId) {
    emit(state.copyWith(selectedItemId: itemId, selectedCartItemId: ''));
  }

  void selectActiveCartItem(CartItem cartItem) {
    emit(state.copyWith(
        selectedCartItemId: cartItem.itemRef.id, selectedItemId: ''));
  }
}
