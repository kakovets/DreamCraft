import 'package:dream_craft/models/review.dart';

class Category {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String title;
  final String description;
  final String image;
  final double marksAvgMark;
  final int popularity;
  final List<Review> comments;
  bool userRated = true;

  Category({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    required this.description,
    required this.image,
    required this.marksAvgMark,
    required this.popularity,
    required this.comments,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    List<Review> commentsList = [];
    if (json['comments'] != null) {
      json['comments'].forEach((commentJson) {
        commentsList.add(Review.fromJson(commentJson));
      });
    }

    return Category(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      title: json['title'],
      description: json['description'],
      image: json['image'],
      marksAvgMark: json['marks_avg_mark'].toDouble() ?? 0.0,
      popularity: json['popularity'].toInt() ?? 0,
      comments: commentsList,
    );
  }

}