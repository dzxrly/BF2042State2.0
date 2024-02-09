import 'package:flutter/material.dart';

class InfoListItemContent {
  final String keyName;
  final String? showValueString;

  InfoListItemContent({required this.keyName, this.showValueString});
}

class InfoListItem extends StatelessWidget {
  final String keyName;
  final String? showValueString;
  final Color? textColor;

  const InfoListItem(
      {required this.keyName, this.showValueString, this.textColor, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(keyName, style: Theme.of(context).textTheme.bodyMedium),
          Text(
            showValueString ?? 'Unknown',
            style: TextStyle(
              fontWeight: Theme.of(context).textTheme.bodyMedium?.fontWeight,
              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
              color: textColor ?? Theme.of(context).colorScheme.primary,
            ),
          )
        ],
      ),
    );
  }
}
