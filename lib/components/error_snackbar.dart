import 'package:flutter/material.dart';

class ErrorSnackBar {
  static void showErrorSnackBar(
      BuildContext context, String errorMsg, double widthScale) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            color: Theme.of(context).colorScheme.onError,
          ),
          const Padding(padding: EdgeInsets.only(left: 8)),
          Text(
            errorMsg,
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
      backgroundColor: Theme.of(context).colorScheme.error,
      width: MediaQuery.of(context).size.width * widthScale,
      clipBehavior: Clip.antiAlias,
    ));
  }
}
