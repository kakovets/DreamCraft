class Review {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String text;
  final bool isEdit;
  final int categoryId;
  final int userId;

  Review({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.text,
    required this.isEdit,
    required this.categoryId,
    required this.userId,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      text: json['text'],
      isEdit: json['is_edit'] == "1",
      categoryId: json['category_id'],
      userId: json['user_id'],
    );
  }
}
