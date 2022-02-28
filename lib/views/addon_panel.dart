import 'package:flutter/material.dart';
import 'package:kioskflutter/component/addons.dart';
import 'package:kioskflutter/component/panels.dart';
import 'package:kioskflutter/model/addonmodel.dart';
import 'package:kioskflutter/model/catalog.dart';

class AddOnPanel extends StatefulWidget {
  final AddOnGroupViewModel addOnGroupViewModel;
  final Function(AddOnGroup, String, bool) onAddOnSelected;

  const AddOnPanel({
    Key? key,
    required this.addOnGroupViewModel,
    required this.onAddOnSelected,
  }) : super(key: key);

  @override
  State<AddOnPanel> createState() => _AddOnPanelState();
}

class _AddOnPanelState extends State<AddOnPanel> {
  int updated = 0;

  _AddOnPanelState();

  void _whenAddOnSelected(
    AddOnGroup addOnGroup,
    String addOnId,
    bool selected,
  ) {
    setState(() {
      updated++;
      if (selected) {
        widget.addOnGroupViewModel.selectAddOns(addOnGroup, [addOnId]);
      } else {
        widget.addOnGroupViewModel.deselectAddOns(addOnGroup, [addOnId]);
      }
    });

    widget.onAddOnSelected(addOnGroup, addOnId, selected);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.addOnGroupViewModel.addOnGroups.isEmpty) {
      return const CenteredPanel(
        message: "No Add-On is required for this item!",
      );
    }

    List<Widget> children = [];
    for (AddOnGroup group in widget.addOnGroupViewModel.addOnGroups) {
      children.addAll(_generateAddOnGroup(context, group));
    }
    if (children.isNotEmpty) {
      children.add(const EndOfSection());
    }

    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  List<Widget> _generateAddOnGroup(
    BuildContext context,
    AddOnGroup addOnGroup,
  ) {
    final ScrollController _controller = ScrollController();
    List<AddOn> childAddOns =
        widget.addOnGroupViewModel.getAddOnsOf(addOnGroup);
    return [
      AddOnTitle(
        key: Key("addontitle-${addOnGroup.id}"),
        addOnGroupTitle: addOnGroup.name,
        subTitle: widget.addOnGroupViewModel.getSubText(addOnGroup),
        allGood: widget.addOnGroupViewModel.isAddOnGroupFulfilled(addOnGroup),
      ),
      Scrollbar(
        key: Key("addonscroll-${addOnGroup.id}"),
        showTrackOnHover: true,
        controller: _controller,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: _controller,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: childAddOns
                .map(
                  (e) => AddOnOption(
                    key: Key("ag-${addOnGroup.id}-${e.id}"),
                    addOn: e,
                    isDisabled:
                        widget.addOnGroupViewModel.isDisabled(addOnGroup),
                    isSelected: widget.addOnGroupViewModel
                        .isSelected(addOnGroup.id, e.id),
                    onClicked: (addOnId, selected) {
                      _whenAddOnSelected(addOnGroup, addOnId, selected);
                    },
                  ),
                )
                .toList(),
          ),
        ),
      ),
      const SizedBox(
        height: 42,
      )
    ];
  }
}
