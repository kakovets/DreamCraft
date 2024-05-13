import 'package:dream_craft/screens/settings/settings_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../generated/locale_keys.g.dart';
import '../providers/category_provider.dart';
import 'categories/categories_screen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<CategoryProvider>().getPlans(
      locale: context.locale.languageCode,
    );
  }

  int selectedScreen = 0;

  List navBarScreens = [
    const CategoriesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DreamCraft'),
      ),
      extendBodyBehindAppBar: true,
      body: navBarScreens[selectedScreen],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedScreen,
        onTap: (index) {
          setState(() {
            selectedScreen = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: LocaleKeys.categories.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.account_circle),
            label: LocaleKeys.profile.tr(),
          ),
        ],
      ),
    );
  }
}