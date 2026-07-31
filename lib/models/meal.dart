class Meal {
  final String id;
  final String name;
  final String thumbnail;
  final String category;

  Meal({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.category,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['idMeal'],
      name: json['strMeal'],
      thumbnail: json['strMealThumb'],
      category: json['strCategory'] ?? '',
    );
  }
}