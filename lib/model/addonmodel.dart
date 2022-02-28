import 'dart:collection';

import 'package:kioskflutter/blocs/catalog/catalog_state.dart';
import 'package:kioskflutter/model/cart.dart';
import 'package:kioskflutter/model/catalog.dart';

class AddOnGroupViewModel {
  final List<AddOnGroup> addOnGroups;
  final Map<String, List<AddOn>> addOns;
  Map<String, Set<String>> selectedAddOns =
      LinkedHashMap<String, Set<String>>();
  bool _mandatoryGroupsExists = false;
  bool requiredMore = false;

  AddOnGroupViewModel(
    this.addOnGroups,
    this.addOns,
  ) {
    if (addOnGroups.isNotEmpty) {
      _mandatoryGroupsExists =
          addOnGroups.indexWhere((element) => element.mandatory) >= 0;
      _derivePendingMoreStatus();
    }
  }

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
      return "Select only one";
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

  bool? isAddOnGroupFulfilled(AddOnGroup group) {
    if (group.mandatory) {
      Set<String>? selectedSet = selectedAddOns[group.id];
      if (selectedSet == null || selectedSet.length < group.min) {
        return false;
      }
      return true;
    } else {
      if (group.max > 0) {
        Set<String>? selectedSet = selectedAddOns[group.id];
        if (selectedSet != null) {
          if (selectedSet.length == group.max) {
            return true;
          } else if (selectedSet.length > group.max) {
            return false;
          }
        }
      }
      return null;
    }
  }

  Map<String, List<SelectedAddOn>> deriveSelectedAddOns() {
    Map<String, List<SelectedAddOn>> map = {};
    for (var addOnGrp in addOnGroups) {
      List<SelectedAddOn> temp = [];
      Set<String> value = selectedAddOns[addOnGrp.id] ?? {};
      for (var e in value) {
        var groupAddOns = addOns[addOnGrp.id];
        if (groupAddOns != null) {
          temp.addAll(
            groupAddOns.where((element) => element.id == e).map(
                  (e) => SelectedAddOn(addOnRef: e, unitPrice: e.price ?? 0.0),
                ),
          );
        }
      }

      if (temp.isNotEmpty) {
        map[addOnGrp.id] = temp;
      }
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

    _derivePendingMoreStatus();
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

    _derivePendingMoreStatus();
  }

  void _derivePendingMoreStatus() {
    if (!_mandatoryGroupsExists) {
      requiredMore = false;
      return;
    }

    requiredMore = false;
    for (var ag in addOnGroups) {
      if (ag.mandatory) {
        Set<String>? selectedSet = selectedAddOns[ag.id];
        if (selectedSet == null || selectedSet.length < ag.min) {
          requiredMore = true;
          return;
        }
      }
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
    obj._derivePendingMoreStatus();
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
