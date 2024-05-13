import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/history.dart';
import 'history_plan_card.dart';

class HistoryGreetingCard extends StatelessWidget {
  const HistoryGreetingCard({super.key, required this.historyGreeting});

  final HistoryGreeting historyGreeting;

  @override
  Widget build(BuildContext context) {

    return HistoryCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat("yyyy-MM-dd",)
                .format(historyGreeting.addedAt),
          ),

          const SizedBox(height: 24,),

          Text(historyGreeting.message),
        ],
      ),
    );
  }
}
