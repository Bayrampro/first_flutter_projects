import 'package:flutter/material.dart';

import '../ui.dart';

class ResultSummary extends StatelessWidget {
  const ResultSummary({
    super.key,
    required this.summary,
  });

  final List<Map<String, dynamic>> summary;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        child: Column(
          children: summary.map((e) {
            return SummaryItem(
              e: e,
            );
          }).toList(),
        ),
      ),
    );
  }
}
