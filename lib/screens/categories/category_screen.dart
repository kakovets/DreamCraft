import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dream_craft/models/category.dart';
import 'package:dream_craft/providers/auth_provider.dart';
import 'package:dream_craft/providers/category_provider.dart';
import 'package:dream_craft/widgets/background_gradient.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../../generated/locale_keys.g.dart';
import '../../theme/theme.dart';
import '../../widgets/category_comment_card.dart';
import '../../widgets/gradient_text.dart';

enum SortCommentOption { dateAsc, dateDesc }

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key, required this.id});

  final int id;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  late Category category;
  int _rating = 0;
  TextEditingController commentController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<CategoryProvider>().getCategory(
      widget.id,
      locale: context.locale.languageCode,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundGradient(
      child: Scaffold(
        appBar: AppBar(),
        body: Consumer2<CategoryProvider, Auth>(
          builder: (context, categoryProvider, authProvider, _) {

            category = categoryProvider.categoriesList
                .firstWhere((cat) => cat.id == widget.id);

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Column(
                  children: [
                    Text(
                      category.title,
                      style: const TextStyle(
                        fontSize: 32,
                      ),
                    ),

                    const SizedBox(height: 24,),

                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      child: CachedNetworkImage(
                        imageUrl: category.image,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Icon(
                          Icons.cloud,
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                    const SizedBox(height: 16,),
                    Text(category.description),
                    const SizedBox(height: 16,),

                    category.userRated
                        ? const SizedBox()
                        :
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RatingBar.builder(
                            initialRating: _rating.toDouble(),
                            minRating: 1,
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                            itemSize: 28,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.orangeAccent,
                            ),
                            onRatingUpdate: (rating) {
                              _rating = rating.toInt();
                              log('$_rating');
                            },
                          ),
                          TextButton(
                            onPressed: () {
                              if (_rating > 0 && _rating < 6) {
                                categoryProvider.rateCategory(
                                  categoryId: category.id,
                                  mark: _rating,
                                  locale: context.locale.languageCode,
                                );
                              } else {
                                log('incorrect mark');
                              }
                            },
                            child: Text(
                              LocaleKeys.rate.tr(),
                              style: TextStyle(
                                color: Theme.of(context).extension<MyColors>()!
                                    .greenyCyan,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8,),

                    Row(
                      children: [
                        Text(
                          LocaleKeys.currently_used.tr(),
                          style: const TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                        Text(
                          ': ${category.popularity}%',
                          style: const TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.orangeAccent,
                        ),
                        const SizedBox(width: 4,),
                        Text(
                          '${category.marksAvgMark}',
                          style: const TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8,),

                    const SizedBox(height: 16,),

                    authProvider.user?.categoryId == category.id
                        ?
                    FilledButton(
                      child: GradientText(
                        LocaleKeys.decline.tr(),
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
                      onPressed: () async {
                        await Provider.of<Auth>(context, listen: false)
                            .chooseCategory(category.id);

                        categoryProvider.getCategory(
                          category.id,
                          locale: context.locale.languageCode,
                        );

                      },
                    )
                        :
                    FilledButton(
                      child: GradientText(
                        LocaleKeys.choose.tr(),
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
                      onPressed: () async {
                        await Provider.of<Auth>(context, listen: false)
                            .chooseCategory(category.id);
                        log('chosen');
                        categoryProvider.getCategory(
                          category.id,
                          locale: context.locale.languageCode,
                        );
                      },
                    ),

                    const SizedBox(height: 32,),

                    Row(
                      children: [
                        PopupMenuButton<SortCommentOption>(
                          onSelected: (newValue) {
                            setState(() {
                              switch(newValue) {
                                case SortCommentOption.dateAsc: {
                                  category.comments.sort((a, b) => a.createdAt.compareTo(b.createdAt));
                                }
                                case SortCommentOption.dateDesc: {
                                  category.comments.sort((a, b) => b.createdAt.compareTo(a.createdAt));
                                }
                              }
                            });
                          },
                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem<SortCommentOption>(
                                value: SortCommentOption.dateDesc,
                                child: Text(LocaleKeys.sort_rev_his_newest.tr()),
                              ),
                              PopupMenuItem<SortCommentOption>(
                                value: SortCommentOption.dateAsc,
                                child: Text(LocaleKeys.sort_rev_his_oldest.tr()),
                              ),
                            ];
                          },
                          child: Row(
                            children: [
                              Text(
                                LocaleKeys.reviews.tr(),
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

                    const SizedBox(height: 16,),

                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: commentController,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              hintText: LocaleKeys.hint_write_review.tr(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8,),
                        FilledButton(
                          onPressed: () {
                            if (commentController.text.isNotEmpty) {
                              commentController.text = '';
                              context.read<CategoryProvider>().postComment(
                                categoryId: category.id,
                                comment: commentController.text,
                                locale: context.locale.languageCode,
                              );
                            } else {
                              log('empty comment');
                            }
                          },
                          style: const ButtonStyle(
                            fixedSize: MaterialStatePropertyAll(
                              Size(
                                double.infinity,
                                48,
                              ),
                            ),
                            backgroundColor: MaterialStatePropertyAll(
                              Color(0xFF69BBED),
                            ),
                          ),
                          child: const Icon(Icons.send),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8,),

                    ...category.comments.map((comment) =>
                        CategoryReviewCard(
                          key: ValueKey(comment.id),
                          review: comment,
                        ),
                    ),

                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

}