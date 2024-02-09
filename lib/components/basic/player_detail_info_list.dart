import 'package:flutter/material.dart';

class TouchableListItem extends StatelessWidget {
  final List<Widget> expandChildren;
  final Function? onTap;

  const TouchableListItem(
      {super.key, required this.expandChildren, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(19),
      onTap: onTap as void Function()?,
      child: Container(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: expandChildren,
        ),
      ),
    );
  }
}

class TouchableList extends StatelessWidget {
  final List<Widget> listTitle;
  final Widget listChild;

  const TouchableList(
      {super.key, required this.listTitle, required this.listChild});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: listTitle,
                )),
            Expanded(child: listChild),
          ],
        ));
  }
}
