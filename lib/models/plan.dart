class Plan {
  final int id;
  final String title;
  final int duration;
  final double price;
  final String description;
  final String restrictions;

  Plan({
    required this.id,
    required this.title,
    required this.duration,
    required this.price,
    required this.description,
    required this.restrictions,
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      id: json['id'],
      title: json['title'],
      duration: json['duration'],
      price: json['price'].toDouble(),
      description: json['description'],
      restrictions: json['restrictions'],
    );
  }
}