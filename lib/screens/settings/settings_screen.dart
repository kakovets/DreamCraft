import 'package:dream_craft/screens/settings/tabs/history_tab.dart';
import 'package:dream_craft/screens/settings/tabs/plan_tab.dart';
import 'package:dream_craft/screens/settings/tabs/profile_tab.dart';
import 'package:dream_craft/theme/theme.dart';
import 'package:dream_craft/widgets/background_gradient.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../generated/locale_keys.g.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final PageController _pageController = PageController();
  double _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round().toDouble() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundGradient(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 16,),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: const BoxDecoration(
                  color: Color(0x33000000),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildIndicator(LocaleKeys.plans.tr(), _currentPage == 0),
                    buildIndicator(LocaleKeys.history.tr(), _currentPage == 1),
                    buildIndicator(LocaleKeys.settings.tr(), _currentPage == 2),
                  ],
                ),
              ),

              const SizedBox(height: 24,),

              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page.toDouble();
                    });
                  },
                  children: const [
                    PlanTab(),
                    HistoryTab(),
                    SettingsTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicator(String title, bool isSelected) {
    return GestureDetector(
      onTap: () {
        final page = title == LocaleKeys.plans.tr()
            ? 0
            : title == LocaleKeys.history.tr()
            ? 1
            : 2;
        _pageController.animateToPage(
          page,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: 30,
            height: 3,
            margin: const EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).extension<MyColors>()!.accentCyan
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
