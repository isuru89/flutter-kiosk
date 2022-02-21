import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kioskflutter/blocs/catalog/catalog_bloc.dart';
import 'package:kioskflutter/blocs/catalog/catalog_state.dart';
import 'package:kioskflutter/component/image_entity.dart';
import 'package:kioskflutter/model/catalog.dart';
import 'package:kioskflutter/utils/orders.dart';

class ItemViewContainer extends StatelessWidget {
  const ItemViewContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CatalogBloc bloc = BlocProvider.of<CatalogBloc>(context);
    return BlocBuilder<CatalogBloc, CatalogState>(
      bloc: bloc,
      buildWhen: (prevState, currState) {
        return prevState.selectedCategoryId != currState.selectedCategoryId;
      },
      builder: (ctx, state) {
        return ItemView(
          items: state.selectedItemsInCategory,
          selectedCategory: state.categories[state.selectedCategoryId],
        );
      },
    );
  }
}

class ItemView extends StatelessWidget {
  final List<Item> items;
  final Category? selectedCategory;

  final ScrollController _itemCtrl = ScrollController();

  ItemView({
    Key? key,
    required this.items,
    this.selectedCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: theme.backgroundColor,
      child: SafeArea(
        top: true,
        bottom: true,
        left: false,
        right: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedCategory?.name ?? "",
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                          letterSpacing: 3,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  if (selectedCategory != null)
                    SizedBox(
                      width: 96,
                      child: Divider(
                        thickness: 6,
                        color: theme.primaryColor,
                      ),
                    )
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                controller: _itemCtrl,
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Wrap(
                          runSpacing: 32,
                          spacing: 16,
                          alignment: WrapAlignment.start,
                          children: items
                              .map(
                                (e) => Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      context
                                          .read<CatalogBloc>()
                                          .selectActiveItem(e.id);
                                      Navigator.pushNamed(context, '/item');
                                    },
                                    child: Container(
                                      width: 180,
                                      height: 260,
                                      padding: const EdgeInsets.all(8),
                                      child: Opacity(
                                        opacity: isStockAvailable(e) ? 1 : 0.6,
                                        child: ItemWithNameAndPrice(
                                          label: e.name,
                                          price: e.discount == null
                                              ? e.price
                                              : calculatePriceAfterDiscount(e),
                                          prevPrice: e.discount == null
                                              ? null
                                              : e.price,
                                          subContent: !isStockAvailable(e)
                                              ? Container(
                                                  width: double.infinity,
                                                  color: theme.errorColor,
                                                  child: Text(
                                                    "Out of stock",
                                                    style: theme
                                                        .textTheme.bodyText2
                                                        ?.copyWith(
                                                      fontSize: 16,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                )
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
