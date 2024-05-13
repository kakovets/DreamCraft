import 'package:cached_network_image/cached_network_image.dart';
import 'package:dream_craft/models/category.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../generated/locale_keys.g.dart';
import '../screens/categories/category_screen.dart';
import '../theme/theme.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: ValueKey(category.id),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => CategoryScreen(
              id: category.id,
            )),
          ),
        );
      },
      child: Container(
        key: ValueKey(category.id),
        margin: const EdgeInsets.symmetric(vertical: 16),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        decoration: BoxDecoration(
          color: Theme.of(context).extension<MyColors>()!
              .transparentWhite,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: category.image,
                  placeholder: (context, url) => const Icon(
                    Icons.cloud,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(height: 16,),
            Text(
              category.title,
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 16,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(LocaleKeys.currently_used.tr()),
                Text(': ${category.popularity}%'),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.orangeAccent,
                ),
                const SizedBox(width: 4,),
                Text('${category.marksAvgMark}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}