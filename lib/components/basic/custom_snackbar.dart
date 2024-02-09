import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class CustomSnackBar {
  static Flushbar showSnackBar(
    BuildContext context,
    String msg, {
    Duration duration = const Duration(seconds: 2),
    String type = 'error',
    FlushbarPosition position = FlushbarPosition.TOP,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(19)),
    EdgeInsets margin = const EdgeInsets.only(left: 16, right: 16, bottom: 16),
    IconData iconData = Icons.error,
  }) {
    return Flushbar(
      message: msg,
      duration: duration,
      flushbarPosition: position,
      borderRadius: borderRadius,
      backgroundColor: type == 'error'
          ? Theme.of(context).colorScheme.error
          : Theme.of(context).colorScheme.primary,
      margin: margin,
      icon: Icon(
        iconData,
        color: type == 'error'
            ? Theme.of(context).colorScheme.onError
            : Theme.of(context).colorScheme.onPrimary,
      ),
      messageSize: Theme.of(context).textTheme.titleMedium?.fontSize,
    );
  }
}
