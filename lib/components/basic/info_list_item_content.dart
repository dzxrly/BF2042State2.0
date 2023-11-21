import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InfoListItemContent {
  final String keyName;
  final double? showValue;
  final String? showValueString;
  final int? fractionDigits;

  InfoListItemContent(
      {required this.keyName,
      this.showValue,
      this.showValueString,
      this.fractionDigits});
}

class InfoListItem extends StatelessWidget {
  final String keyName;
  final double? showValue;
  final String? showValueString;
  final int? fractionDigits;
  final Color? textColor;
  final NumberFormat numberFormat = NumberFormat.decimalPattern('en_us');

  InfoListItem(
      {required this.keyName,
      this.showValue,
      this.showValueString,
      this.fractionDigits,
      this.textColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(keyName, style: Theme.of(context).textTheme.bodyMedium),
          Text(
            showValue != null
                ? numberFormat.format(double.parse(
                    showValue!.toStringAsFixed(fractionDigits ?? 2)))
                : showValueString ?? '未知',
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
