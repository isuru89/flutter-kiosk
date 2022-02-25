import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kioskflutter/blocs/catalog/catalog_bloc.dart';
import 'package:kioskflutter/blocs/catalog/catalog_state.dart';
import 'package:kioskflutter/component/image_entity.dart';
import 'package:kioskflutter/component/labels.dart';
import 'package:kioskflutter/component/panels.dart';
import 'package:kioskflutter/feature_flags.dart';
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

class ItemView extends StatefulWidget {
  final List<Item> items;
  final Category? selectedCategory;

  const ItemView({Key? key, required this.items, this.selectedCategory})
      : super(key: key);

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  final ScrollController _itemCtrl = ScrollController();
  bool showOutOfStock = true;

  @override
  Widget build(BuildContext context) {
    if (widget.selectedCategory == null) {
      return const CenteredPanel(
        message: "Select a category",
      );
    }
    if (widget.items.isEmpty) {
      return const CenteredPanel(
        message: "No items available in this category!",
      );
    }

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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: MainHeader(
                      title: widget.selectedCategory?.name,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Show Out of Stocks",
                        style: theme.textTheme.bodyText1,
                      ),
                      CupertinoSwitch(
                        activeColor: theme.primaryColor,
                        value: showOutOfStock,
                        onChanged: (value) {
                          setState(() {
                            showOutOfStock = value;
                          });
                        },
                      ),
                    ],
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
                          runSpacing: kMenuViewItemVerticleSpacing,
                          spacing: kMenuViewItemHorizonatalSpacing,
                          alignment: WrapAlignment.start,
                          children: widget.items
                              .where((element) =>
                                  showOutOfStock || isStockAvailable(element))
                              .map((e) => _buildItem(context, e))
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

  Widget _buildItem(BuildContext context, Item item) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          var bloc = context.read<CatalogBloc>();
          await bloc.loadAddOnsOfItem(itemId: item.id);
          bloc.selectActiveItem(item.id);
          Navigator.pushNamed(context, '/item');
        },
        child: Container(
          width: 180,
          height: 320,
          padding: const EdgeInsets.all(8),
          child: ItemWithNameAndPrice(
            opacity: isStockAvailable(item) ? 1 : 0.4,
            label: item.name,
            imageUrl: item.imageUrl,
            price: item.discount == null
                ? item.price
                : calculatePriceAfterDiscount(item),
            prevPrice: item.discount == null ? null : item.price,
            circular: kCircularItemImages,
            subContent: !isStockAvailable(item)
                ? const UnavailableContent(
                    circular: kCircularItemImages,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
