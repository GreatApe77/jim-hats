import 'package:flutter/material.dart';

class StatsItem extends StatelessWidget {
  final String label;
  final String value;
  const StatsItem({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        )
      ],
    );
  }
}
