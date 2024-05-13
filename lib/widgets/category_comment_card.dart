import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/review.dart';
import '../providers/auth_provider.dart';
import '../providers/category_provider.dart';
import '../theme/theme.dart';

class CategoryReviewCard extends StatefulWidget {
  const CategoryReviewCard({
    super.key,
    required this.review,
  });

  final Review review;

  @override
  State<CategoryReviewCard> createState() => _CategoryReviewCardState();
}

class _CategoryReviewCardState extends State<CategoryReviewCard> {

  String avatarUrl = '';
  String reviewerName = '';

  @override
  void initState() {
    super.initState();
    getInfoAboutReviewer(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).extension<MyColors>()!
            .transparentWhite,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat("yyyy-MM-dd' 'HH:mm",)
                    .format(widget.review.createdAt.toLocal()),
              ),
              if (Provider.of<Auth>(context, listen: false).user!.role == 'admin')
                IconButton(
                  onPressed: () {
                  },
                  icon: const Icon(Icons.more_vert),
                ),
            ],
          ),
          const SizedBox(height: 16,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipOval(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .15,
                  height: MediaQuery.of(context).size.width * .15,
                  child:
                  avatarUrl.isEmpty
                      ?
                  Container(
                    height: 64,
                    width: 64,
                    color: Colors.grey,
                  )
                      :
                  CachedNetworkImage(
                    imageUrl: avatarUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Icon(
                      Icons.cloud,
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ),

              const SizedBox(width: 16,),
              Text('@$reviewerName'),
            ],
          ),

          const SizedBox(height: 16,),

          Row(
            children: [
              Expanded(
                child: Text(
                  widget.review.text,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void getInfoAboutReviewer(BuildContext context) async {
    var user = await context.read<CategoryProvider>()
        .getUserById(userId: widget.review.userId);
    setState(() {
      avatarUrl = user!.avatar;
      reviewerName = user.nickname;
    });
  }
}