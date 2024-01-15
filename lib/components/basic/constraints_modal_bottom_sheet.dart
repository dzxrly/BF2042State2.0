import 'package:flutter/material.dart';

class ConstraintsModalBottomSheet {
  static void showConstraintsModalBottomSheet(
      BuildContext context, Widget child) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          // only top left and top right corner
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(19),
            topRight: Radius.circular(19),
          ),
        ),
        builder: (BuildContext context) {
          return SafeArea(
              child: AnimatedPadding(
            padding: MediaQuery.of(context).viewInsets,
            duration: const Duration(milliseconds: 150),
            child: Container(
              constraints: BoxConstraints(
                minHeight: 50,
                maxHeight: MediaQuery.of(context).size.height * 0.5,
              ),
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
                bottom: 8,
              ),
              child: child,
            ),
          ));
        });
  }
}
