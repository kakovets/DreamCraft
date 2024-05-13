import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../generated/locale_keys.g.dart';
import '../models/plan.dart';
import '../providers/auth_provider.dart';
import '../theme/theme.dart';
import 'gradient_text.dart';

class PlanCard extends StatelessWidget {
  const PlanCard({
    super.key,
    required this.plan,
    required this.isPremium,
  });

  final Plan plan;
  final bool isPremium;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey(plan.id),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: isPremium
            ? Theme.of(context).extension<MyColors>()!.transparentGreen
            : Theme.of(context).extension<MyColors>()!.transparentWhite,
        border: isPremium
            ? Border.all(width: 3, color: Colors.white)
            : Border.all(width: 1, color: Colors.black),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        children: [
          Text(
            plan.title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).extension<MyColors>()!
                  .acidGreen,
            ),
          ),
          const SizedBox(height: 24,),
          Text(plan.description),
          const SizedBox(height: 8,),
          Text(
            '\$${plan.price}/${LocaleKeys.month.tr()}',
            style: TextStyle(
              color: Theme.of(context).extension<MyColors>()!.greenyCyan,
            ),
          ),
          const SizedBox(height: 8,),
          Text(
            plan.restrictions,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 24,),

          if (!isUserSubscribed(context))
            FilledButton(
              onPressed: () {
                if (isUserSubscribed(context)) {
                  return;
                }
                context.read<Auth>().subscribeToPlan(plan.id);
              },
              style: ButtonStyle(
                backgroundColor: isUserSubscribed(context)
                    ? const MaterialStatePropertyAll(Colors.grey)
                    : MaterialStatePropertyAll(Theme.of(context).extension<MyColors>()!.accentCyan) ,
              ),
              child: GradientText(
                LocaleKeys.subscribe.tr(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[
                    Theme.of(context).extension<MyColors>()!
                        .buttonGradientFirst,
                    Theme.of(context).extension<MyColors>()!
                        .buttonGradientSecond,
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  bool isUserSubscribed(BuildContext context) {
    return context.read<Auth>().user?.planId != null;
  }
}