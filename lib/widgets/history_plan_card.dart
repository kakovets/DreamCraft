import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/history.dart';
import '../theme/theme.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).extension<MyColors>()!.transparentWhite,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: child,
    );
  }
}


class HistoryPlanCard extends StatelessWidget {
  const HistoryPlanCard({super.key, required this.historyPlan});

  final HistoryPlan historyPlan;

  @override
  Widget build(BuildContext context) {

    return HistoryCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat("yyyy-MM-dd",)
                .format(historyPlan.addedAt),
          ),

          const SizedBox(height: 24,),

          Text(historyPlan.print()),
        ],
      ),
    );
  }
}
