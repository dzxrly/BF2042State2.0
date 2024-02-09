import 'package:flutter/material.dart';

class CustomSnackBar {
  static void showSnackBar(
      BuildContext context, String msg, double widthScale, String type) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (type == 'error')
            Icon(
              Icons.error,
              color: Theme.of(context).colorScheme.onError,
            ),
          if (type == 'info')
            Icon(
              Icons.info,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          const Padding(padding: EdgeInsets.only(left: 8)),
          Text(
            msg,
            style: const TextStyle(fontSize: 14),
            softWrap: true,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(19)),
      ),
      backgroundColor: type == 'error'
          ? Theme.of(context).colorScheme.error
          : Theme.of(context).colorScheme.primary,
      width: MediaQuery.of(context).size.width * widthScale,
      clipBehavior: Clip.antiAlias,
      duration: const Duration(seconds: 1),
    ));
  }
}
