import 'package:flutter/material.dart';
import 'package:kioskflutter/component/addons.dart';
import 'package:kioskflutter/component/panels.dart';
import 'package:kioskflutter/model/addonmodel.dart';
import 'package:kioskflutter/model/catalog.dart';

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
    children.add(const EndOfSection());

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
                .map(
                  (e) => AddOnOption(
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
                  ),
                )
                .toList(),
          ),
        ),
      ),
      const SizedBox(
        height: 24,
      )
    ];
  }
}
