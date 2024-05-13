import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../generated/locale_keys.g.dart';

enum SortCategoriesOption { popularityAsc, popularityDesc, markAsc, markDesc, alphabet }

class SortCategoriesPopup extends StatelessWidget {
  const SortCategoriesPopup({super.key, required this.callback});

  final Function callback;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SortCategoriesOption>(
      icon: const Icon(
        Icons.sort,
        size: 26,
      ),
      onSelected: (newValue) => callback(newValue),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<SortCategoriesOption>(
            value: SortCategoriesOption.popularityDesc,
            child: Text(LocaleKeys.sort_categories_most_popular.tr()),
          ),
          PopupMenuItem<SortCategoriesOption>(
            value: SortCategoriesOption.popularityAsc,
            child: Text(LocaleKeys.sort_categories_least_popular.tr()),
          ),
          PopupMenuItem<SortCategoriesOption>(
            value: SortCategoriesOption.markDesc,
            child: Text(LocaleKeys.sort_categories_most_rated.tr()),
          ),
          PopupMenuItem<SortCategoriesOption>(
            value: SortCategoriesOption.markAsc,
            child: Text(LocaleKeys.sort_categories_least_rated.tr()),
          ),
          PopupMenuItem<SortCategoriesOption>(
            value: SortCategoriesOption.alphabet,
            child: Text(LocaleKeys.sort_categories_alphabet.tr()),
          ),
        ];
      },
    );
  }
}
