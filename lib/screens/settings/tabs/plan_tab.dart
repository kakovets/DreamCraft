import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../models/user.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/category_provider.dart';
import '../../../theme/theme.dart';
import '../../../widgets/plan_card.dart';

class PlanTab extends StatelessWidget {
  const PlanTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<Auth, CategoryProvider>(
      builder: (context, authProvider, categoryProvider, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).extension<MyColors>()!.transparentWhite,
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(LocaleKeys.your_current_plan.tr()),

                          Text(
                            getUserPlan(context),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).extension<MyColors>()!
                                  .acidGreen,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(LocaleKeys.subscription_till.tr()),
                          Text(
                            getSubTill(context),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16,),

                      if (authProvider.user?.planId != null)
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (authProvider.user?.planId == null) {
                                  return;
                                }

                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: Text(
                                        LocaleKeys.sure_cancel_sub.tr(),
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(LocaleKeys.no.tr()),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            authProvider.unsubscribe();
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(LocaleKeys.yes.tr()),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text(
                                LocaleKeys.cancel_subscription.tr(),
                                style: const TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 16,),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: categoryProvider.planList.length,
                  itemBuilder: (context, index) {
                    var plan = categoryProvider.planList[index];
                    return PlanCard(
                      plan: plan,
                      isPremium: index == categoryProvider.planList.length - 1,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String getSubTill(BuildContext context) {
    User? user = Provider.of<Auth>(context, listen: false).user;

    if (user == null) {
      return LocaleKeys.unauthorized.tr();
    }
    if (user.durationPlan == null) {
      return LocaleKeys.no_plan.tr();
    }

    return DateFormat("yyyy-MM-dd' 'HH:mm",)
        .format(user.durationPlan!);
  }

  String getUserPlan(BuildContext context) {

    User? user = Provider.of<Auth>(context, listen: false).user;

    if (user == null) {
      return LocaleKeys.unauthorized.tr();
    }

    var planList = Provider.of<CategoryProvider>(context, listen: false)
        .planList;

    if (user.planId == null || planList.isEmpty) {
      return LocaleKeys.no_plan.tr();
    }

    String plan = planList.firstWhere(
          (plan) => plan.id == user.planId,)
        .title ;
    return plan;
  }
}
