import 'package:flutter/material.dart';

class ErrorChip extends StatelessWidget {
  final String label;

  const ErrorChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(19),
      ),
      side: BorderSide(color: Theme.of(context).colorScheme.error),
      avatar: Icon(Icons.warning,
          color: Theme.of(context).colorScheme.error,
          size: Theme.of(context).textTheme.bodySmall?.fontSize),
      label: Text(label,
          softWrap: true,
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
            fontWeight: Theme.of(context).textTheme.bodySmall?.fontWeight,
            color: Theme.of(context).colorScheme.error,
          )),
    );
  }
}
