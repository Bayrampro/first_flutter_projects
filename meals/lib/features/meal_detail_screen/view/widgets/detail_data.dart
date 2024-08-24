import 'package:flutter/material.dart';

import '../../../../models/models.dart';

class DetailData extends StatelessWidget {
  const DetailData({
    super.key,
    required this.meal,
    required this.label,
    required this.data,
    required this.padding,
  });

  final Meal meal;
  final String label;
  final List<String> data;
  final double padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Text(
            label,
            style: theme.textTheme.titleLarge!.copyWith(
              color: Colors.orange.withOpacity(0.5),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          ...data.map(
            (e) => Padding(
              padding: EdgeInsets.only(top: padding),
              child: Text(
                e,
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
