import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/history.dart';
import 'history_plan_card.dart';

class HistoryCategoryCard extends StatelessWidget {
  const HistoryCategoryCard({super.key, required this.historyCategory});

  final HistoryCategory historyCategory;

  @override
  Widget build(BuildContext context) {

    return HistoryCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat("yyyy-MM-dd",)
                .format(historyCategory.addedAt),
          ),

          const SizedBox(height: 24,),

          Text(historyCategory.print()),
        ],
      ),
    );
  }
}
