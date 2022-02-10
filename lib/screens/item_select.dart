import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kioskflutter/blocs/cart/cart_bloc.dart';
import 'package:kioskflutter/blocs/cart/cart_event.dart';
import 'package:kioskflutter/blocs/cart/cart_state.dart';
import 'package:kioskflutter/blocs/catalog/catalog_bloc.dart';
import 'package:kioskflutter/blocs/catalog/catalog_state.dart';
import 'package:kioskflutter/component/button.dart';
import 'package:kioskflutter/component/image_entity.dart';
import 'package:kioskflutter/component/modifiers.dart';
import 'package:kioskflutter/component/panels.dart';
import 'package:kioskflutter/component/quantity.dart';
import 'package:kioskflutter/constants.dart';
import 'package:kioskflutter/model/cart.dart';
import 'package:kioskflutter/model/catalog.dart';

class AddOnGroupViewModel {
  final List<AddOnGroup> addOnGroups;
  final Map<String, List<AddOn>> addOns;
  Map<String, Set<String>> selectedAddOns =
      LinkedHashMap<String, Set<String>>();

  AddOnGroupViewModel(
    this.addOnGroups,
    this.addOns,
  );

  void _fillInitialSelectedAddOns(
      Map<String, List<SelectedAddOn>> addOnsGiven) {
    if (addOnsGiven.isEmpty) {
      return;
    }

    addOnsGiven.forEach((key, value) {
      selectedAddOns[key] = value.map((e) => e.addOnRef.id).toSet();
    });
  }

  String getSubText(AddOnGroup group) {
    if (_isSingleOption(group)) {
      return "Select one";
    }

    if (group.mandatory) {
      if (group.max == group.min) {
        return "Select ${group.max} options";
      } else {
        return "Select at least ${group.min} to ${group.max} options";
      }
    } else {
      if (group.max > group.min) {
        return "Select up to ${group.max} options";
      }
      return "";
    }
  }

  List<AddOn> getAddOnsOf(AddOnGroup group) {
    var addOns = this.addOns[group.id];
    if (addOns != null) {
      return addOns;
    }
    return [];
  }

  Map<String, List<SelectedAddOn>> deriveSelectedAddOns() {
    Map<String, List<SelectedAddOn>> map = {};
    for (var addOnGrp in addOnGroups) {
      List<SelectedAddOn> temp = [];
      Set<String> value = selectedAddOns[addOnGrp.id] ?? {};
      for (var e in value) {
        var groupAddOns = addOns[addOnGrp.id];
        if (groupAddOns != null) {
          temp.addAll(groupAddOns.where((element) => element.id == e).map(
              (e) => SelectedAddOn(addOnRef: e, unitPrice: e.price ?? 0.0)));
        }
      }
      map[addOnGrp.id] = temp;
    }
    return map;
  }

  void deselectAddOns(AddOnGroup group, List<String> addOns) {
    if (_isSingleOption(group)) {
      return;
    }

    Set<String>? selected = selectedAddOns[group.id];
    if (selected != null) {
      var count = selected.length - addOns.length;
      if (count < 0) {
        selected.clear();
        return;
      }
      selected.removeAll(addOns);
    } else {
      selectedAddOns[group.id] = Set.from(addOns);
    }
  }

  void selectAddOns(AddOnGroup group, List<String> addOns) {
    Set<String>? selected = selectedAddOns[group.id];
    if (selected != null) {
      if (_isSingleOption(group)) {
        selected.clear();
        selected.addAll(addOns);
        return;
      }

      var count = selected.length + addOns.length;
      if (count > group.max) {
        return;
      }
      selected.addAll(addOns);
    } else {
      selectedAddOns[group.id] = Set.from(addOns);
    }
  }

  bool _isSingleOption(AddOnGroup group) {
    return group.min == 1 && group.max == 1;
  }

  bool isDisabled(AddOnGroup group) {
    if (_isSingleOption(group)) {
      return false;
    }

    Set<String>? selected = selectedAddOns[group.id];
    if (selected != null) {
      return selected.length >= group.max;
    } else {
      return false;
    }
  }

  bool isSelected(String groupId, String addOn) {
    Set<String>? selected = selectedAddOns[groupId];
    if (selected != null) {
      return selected.contains(addOn);
    }
    return false;
  }

  factory AddOnGroupViewModel.fromCartItem(
      CatalogState state, CartItem cartItem) {
    var obj = AddOnGroupViewModel.fromState(state, cartItem.itemRef);
    obj._fillInitialSelectedAddOns(cartItem.addOns);
    return obj;
  }

  factory AddOnGroupViewModel.fromState(CatalogState state, Item item) {
    if (item.addOnGroupIds.isEmpty) {
      return AddOnGroupViewModel(const [], const {});
    }

    List<AddOnGroup> addOnGroupsRef = [];
    Map<String, List<AddOn>> addOnRefs = {};
    for (String grpId in item.addOnGroupIds) {
      if (state.addOnGroups.containsKey(grpId)) {
        AddOnGroup grp = state.addOnGroups[grpId]!;
        addOnGroupsRef.add(grp);

        if (grp.addOnIds.isNotEmpty) {
          List<AddOn> children = [];
          for (String id in grp.addOnIds) {
            if (state.addOns[id] != null) {
              children.add(state.addOns[id]!);
            }
          }
          addOnRefs[grpId] = children;
        }
      }
    }

    return AddOnGroupViewModel(addOnGroupsRef, addOnRefs);
  }

  @override
  String toString() =>
      'AddOnGroupViewModel(addOnGroups: $addOnGroups, addOns: $addOns)';
}

class ItemSelectContainer extends StatelessWidget {
  const ItemSelectContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CatalogBloc bloc = BlocProvider.of<CatalogBloc>(context);
    return BlocBuilder<CatalogBloc, CatalogState>(
        bloc: bloc,
        builder: (ctx, state) {
          Item? item = state.items[state.selectedItemId];
          print("11111");
          if (item != null) {
            return ItemSelect(
              item: item,
              addOnGroupViewModel: AddOnGroupViewModel.fromState(state, item),
            );
          } else {
            print("22222");
            return BlocBuilder<CartBloc, CartState>(
                builder: (context, cartState) {
              CartItem? cartItem;
              for (var element in cartState.items) {
                if (element.itemRef.id == state.selectedCartItemId) {
                  cartItem = element;
                  break;
                }
              }

              if (cartItem != null) {
                return ItemSelect(
                    item: cartItem.itemRef,
                    addOnGroupViewModel:
                        AddOnGroupViewModel.fromCartItem(state, cartItem));
              } else {
                return Center(child: Text("Select an Item !"));
              }
            });
          }
        });
  }
}

class ItemSelect extends StatefulWidget {
  final Item item;
  final AddOnGroupViewModel addOnGroupViewModel;

  ItemSelect({Key? key, required this.item, required this.addOnGroupViewModel})
      : super(key: key);

  @override
  State<ItemSelect> createState() =>
      _ItemSelectState(addOnGroupViewModel, item: item);
}

class _ItemSelectState extends State<ItemSelect> {
  final Item item;
  final AddOnGroupViewModel addOnGroupViewModel;
  int quantity = 1;

  _ItemSelectState(this.addOnGroupViewModel, {required this.item});

  void _whenQuantityChanged(QuantityChangeType type) {
    if (type == QuantityChangeType.increment) {
      quantity += 1;
    } else {
      quantity = max(quantity - 1, 1);
    }
    setState(() {
      quantity = quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      child: Row(
        children: [
          Flexible(
              flex: 7,
              child: Container(
                  decoration: BoxDecoration(
                      color: theme.shadowColor,
                      border:
                          Border(right: BorderSide(color: Color(0xFF444c56)))),
                  child: ItemSidePanel(
                    item: item,
                    addToCartClicked: () {
                      context.read<CartBloc>().itemModifiedEvent(
                          CartItemModificationEvent.fromCartItem(
                              CartItem(item, quantity,
                                  addOns: addOnGroupViewModel
                                      .deriveSelectedAddOns()),
                              CartItemModificationType.added));
                      Navigator.pop(context);
                    },
                    cancelClicked: () => Navigator.pop(context),
                    quantity: quantity,
                    onQuantityChanged: _whenQuantityChanged,
                  ))),
          Flexible(
              flex: 9,
              child: Container(
                height: double.infinity,
                color: theme.backgroundColor,
                padding: const EdgeInsets.all(24),
                child: AddOnPanel(
                  addOnGroupViewModel: addOnGroupViewModel,
                ),
              ))
        ],
      ),
    );
  }
}

class AddOnPanel extends StatefulWidget {
  final AddOnGroupViewModel addOnGroupViewModel;

  AddOnPanel({Key? key, required this.addOnGroupViewModel}) : super(key: key);

  @override
  State<AddOnPanel> createState() =>
      _AddOnPanelState(addOnGroupViewModel: addOnGroupViewModel);
}

class _AddOnPanelState extends State<AddOnPanel> {
  final AddOnGroupViewModel addOnGroupViewModel;
  int updated = 0;

  _AddOnPanelState({required this.addOnGroupViewModel});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (AddOnGroup group in addOnGroupViewModel.addOnGroups) {
      children.addAll(_generateAddOnGroup(context, group));
    }
    children.add(EndOfSection());

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: children,
      ),
    );
  }

  List<Widget> _generateAddOnGroup(
      BuildContext context, AddOnGroup addOnGroup) {
    final ScrollController _controller = ScrollController();
    List<AddOn> childAddOns = addOnGroupViewModel.getAddOnsOf(addOnGroup);
    return [
      AddOnTitle(
        addOnGroupTitle: addOnGroup.name,
        subTitle: addOnGroupViewModel.getSubText(addOnGroup),
      ),
      Scrollbar(
        showTrackOnHover: true,
        controller: _controller,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: _controller,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: childAddOns
                  .map((e) => AddOnOption(
                        addOn: e,
                        isDisabled: addOnGroupViewModel.isDisabled(addOnGroup),
                        isSelected:
                            addOnGroupViewModel.isSelected(addOnGroup.id, e.id),
                        onClicked: (addOnId, selected) {
                          setState(() {
                            updated++;
                            if (selected) {
                              addOnGroupViewModel
                                  .selectAddOns(addOnGroup, [addOnId]);
                            } else {
                              addOnGroupViewModel
                                  .deselectAddOns(addOnGroup, [addOnId]);
                            }
                          });
                        },
                      ))
                  .toList()),
        ),
      ),
      const SizedBox(
        height: 24,
      )
    ];
  }
}

class ItemSidePanel extends StatelessWidget {
  final Item item;
  final int quantity;
  final Function() addToCartClicked;
  final Function() cancelClicked;
  final Function(QuantityChangeType) onQuantityChanged;

  const ItemSidePanel(
      {Key? key,
      required this.item,
      required this.addToCartClicked,
      required this.cancelClicked,
      required this.quantity,
      required this.onQuantityChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ItemImage(
          imageUrl: item.imageUrl,
          width: 500,
          height: 300,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Text(
            item.name.toUpperCase(),
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            item.description,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(height: 1.5),
          ),
        ),
        if (item.calories != null) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Text(
              "${item.calories} Cal",
              style: Theme.of(context).textTheme.subtitle2,
            ),
          )
        ],
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Quantity(
                    qty: quantity,
                    onIncrease: () =>
                        onQuantityChanged(QuantityChangeType.increment),
                    onDecrease: () =>
                        onQuantityChanged(QuantityChangeType.decrement)),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        "TOTAL: ",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            ?.copyWith(color: kSecondaryTextColor),
                      ),
                    ),
                    PriceLabel(
                      price: item.price,
                      color: theme.primaryColor,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  flex: 9,
                  child: KioskButton(
                      text: "ADD TO CART", onClicked: addToCartClicked)),
              Flexible(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: KioskButton(
                    text: "CANCEL",
                    onClicked: cancelClicked,
                    inactive: true,
                    inactiveColor: kSecondaryTextColor,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
