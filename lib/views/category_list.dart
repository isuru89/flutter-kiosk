import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kioskflutter/blocs/catalog/catalog_bloc.dart';
import 'package:kioskflutter/blocs/catalog/catalog_state.dart';
import 'package:kioskflutter/component/image_entity.dart';
import 'package:kioskflutter/model/catalog.dart';

class CategoryListContainer extends StatelessWidget {
  const CategoryListContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CatalogBloc bloc = BlocProvider.of<CatalogBloc>(context);
    return BlocBuilder<CatalogBloc, CatalogState>(
      bloc: bloc,
      buildWhen: (previous, current) =>
          previous.selectedCategoryId != current.selectedCategoryId ||
          previous.categories != current.categories,
      builder: (ctx, state) => CategoryList(
        categories: state.categories.values.toList(),
        selectedCategory: state.selectedCategoryId,
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  final ScrollController _categoryCtrl = ScrollController();
  final List<Category> categories;
  final String selectedCategory;

  CategoryList(
      {Key? key, required this.categories, required this.selectedCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        color: theme.canvasColor,
        border: Border(right: BorderSide(color: theme.dividerColor)),
      ),
      child: SafeArea(
        top: true,
        bottom: true,
        left: false,
        right: false,
        child: SingleChildScrollView(
          controller: _categoryCtrl,
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: categories
                .map(
                  (e) => Material(
                    key: Key(e.id),
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () async {
                        var bloc = context.read<CatalogBloc>();
                        await bloc.loadItems(categoryId: e.id);
                        bloc.selectActiveCategory(e.id);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 24.0,
                        ),
                        child: SizedBox(
                          height: 180,
                          width: 160,
                          child: CategoryItem(
                            label: e.name,
                            isSelected: e.id == selectedCategory,
                            width: 120,
                            height: 120,
                            imageUrl: e.imageUrl,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
