import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../generated/locale_keys.g.dart';
import '../../models/category.dart';
import '../../providers/category_provider.dart';
import '../../widgets/background_gradient.dart';
import '../../widgets/category_card.dart';
import '../../widgets/sort_categories_popup.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

  TextEditingController categorySearchController = TextEditingController();
  List<Category> filteredCategories = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    init();
  }

  void init() async {
    var lang = context.locale.languageCode;
    await context.read<CategoryProvider>().getCategories(locale: lang);
    filteredCategories = context.read<CategoryProvider>().categoriesList;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, categoriesProvider, _) {
        return BackgroundGradient(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: categorySearchController,
                            textInputAction: TextInputAction.done,
                            onChanged: filterCategories,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              hintText: LocaleKeys.search.tr(),
                            ),
                          ),
                        ),
                        SortCategoriesPopup(callback: sortCategories,),
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredCategories.length,
                      itemBuilder: (context, index) {
                        var category = filteredCategories[index];
                        return CategoryCard(category: category,);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    categorySearchController.dispose();
    super.dispose();
  }

  void filterCategories(String query) {
    setState(() {
      filteredCategories = Provider.of<CategoryProvider>(context, listen: false)
          .categoriesList.where((category) =>
          category.title.toLowerCase().startsWith(query.toLowerCase()),)
          .toList();
    });
  }

  void sortCategories(SortCategoriesOption newValue) {
    setState(() {
      switch(newValue) {
        case SortCategoriesOption.popularityAsc: {
          filteredCategories.sort((a,b) {
            return a.popularity.compareTo(b.popularity);
          });
        }
        case SortCategoriesOption.popularityDesc: {
          filteredCategories.sort((a,b) {
            return b.popularity.compareTo(a.popularity);
          });
        }
        case SortCategoriesOption.markAsc: {
          filteredCategories.sort((a,b) {
            return a.marksAvgMark.compareTo(b.marksAvgMark);
          });
        }
        case SortCategoriesOption.markDesc: {
          filteredCategories.sort((a,b) {
            return b.marksAvgMark.compareTo(a.marksAvgMark);
          });
        }
        case SortCategoriesOption.alphabet: {
          filteredCategories.sort((a,b) {
            return a.title.compareTo(b.title);
          });
        }
      }
    });
  }
}