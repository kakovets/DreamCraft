abstract class History {
  History({
    required this.addedAt,
  });

  final DateTime addedAt;
}

class HistoryGreeting extends History {
  final String message;

  HistoryGreeting({
    required this.message,
    required super.addedAt,
  });
}

class HistoryPlan extends History {
  final String title;
  final String description;

  HistoryPlan({
    required this.title,
    required this.description,
    required super.addedAt,
  });

  String print() {
    return 'You subscribed to $title plan!';
  }
}

class HistoryCategory extends History {
  final String title;

  HistoryCategory({
    required this.title,
    required super.addedAt,
  });

  String print() {
    return 'You chose a $title category!';
  }
}