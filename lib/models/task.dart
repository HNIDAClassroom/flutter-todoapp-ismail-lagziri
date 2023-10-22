
class Task {
  final String title;
  final String description;
  final DateTime date;
  final Category category;

  Task({
    required this.title,
    required this.description,
    required this.date,
    required this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'category': category.toString().split('.').last,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      category: _categoryFromString(json['category']),
    );
  }

  static Category _categoryFromString(String categoryString) {
    for (Category category in Category.values) {
      if (category.toString().split('.').last == categoryString) {
        return category;
      }
    }
    return Category.other; // Default to Category.other if not recognized
  }
}

enum Category {
  personal,
  work,
  study,
  other,
}

