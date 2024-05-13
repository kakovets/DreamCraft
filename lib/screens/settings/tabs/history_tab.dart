import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../models/history.dart';
import '../../../providers/auth_provider.dart';
import '../../../widgets/history_category_card.dart';
import '../../../widgets/history_greeting_card.dart';
import '../../../widgets/history_plan_card.dart';

enum SortHistoryOption { dateAsc, dateDesc }

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (context, authProvider, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    PopupMenuButton<SortHistoryOption>(
                      onSelected: (newValue) {
                        setState(() {
                          switch(newValue) {
                            case SortHistoryOption.dateAsc: {
                              authProvider.user!.history!
                                  .sort((a, b) =>
                                  a.addedAt.compareTo(b.addedAt));
                            }
                            case SortHistoryOption.dateDesc: {
                              authProvider.user!.history!
                                  .sort((a, b) =>
                                  b.addedAt.compareTo(a.addedAt));
                            }
                          }
                        });
                      },
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem<SortHistoryOption>(
                            value: SortHistoryOption.dateDesc,
                            child: Text(LocaleKeys.sort_rev_his_newest.tr()),
                          ),
                          PopupMenuItem<SortHistoryOption>(
                            value: SortHistoryOption.dateAsc,
                            child: Text(LocaleKeys.sort_rev_his_oldest.tr()),
                          ),
                        ];
                      },
                      child: Row(
                        children: [
                          Text(
                            LocaleKeys.sort.tr(),
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 4,),
                          const Icon(
                            Icons.sort,
                            size: 28,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: authProvider.user!.history!.length,
                  itemBuilder: (context, index) {
                    var history = authProvider.user!.history![index];
                    switch (history.runtimeType) {
                      case HistoryGreeting: return HistoryGreetingCard(historyGreeting: history);
                      case HistoryCategory: return HistoryCategoryCard(historyCategory: history);
                      case HistoryPlan: return HistoryPlanCard(historyPlan: history);
                      default: return Text(LocaleKeys.something_went_wrong.tr());
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}