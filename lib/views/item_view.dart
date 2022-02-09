import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kioskflutter/blocs/catalog/catalog_bloc.dart';
import 'package:kioskflutter/blocs/catalog/catalog_state.dart';
import 'package:kioskflutter/component/image_entity.dart';
import 'package:kioskflutter/constants.dart';
import 'package:kioskflutter/model/catalog.dart';

class ItemViewContainer extends StatelessWidget {
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
        });
  }
}

class ItemView extends StatelessWidget {
  final List<Item> items;
  final Category? selectedCategory;

  final ScrollController _itemCtrl = ScrollController();

  ItemView({Key? key, required this.items, this.selectedCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            selectedCategory?.name ?? "",
            style: Theme.of(context)
                .textTheme
                .headline2
                ?.copyWith(letterSpacing: 3),
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
                          .map((e) => Container(
                                width: 180,
                                height: 260,
                                child: GestureDetector(
                                  onTap: () {
                                    context
                                        .read<CatalogBloc>()
                                        .selectActiveItem(e.id);
                                    Navigator.pushNamed(context, '/item');
                                  },
                                  child: ItemWithNameAndPrice(
                                      label: e.name,
                                      price: "\$${e.price.toStringAsFixed(2)}"),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
