class Recipe {
  final int id;
  final String title;
  final String imageUrl;
  final int usedIngredientCount;
  final int missedIngredientCount;
  final int likes;

  Recipe({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.usedIngredientCount,
    required this.missedIngredientCount,
    required this.likes,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: json['title'],
      imageUrl: json['image'],
      usedIngredientCount: json['used_ingredient_count'],
      missedIngredientCount: json['missed_ingredient_count'],
      likes: json['likes'],
    );
  }
}
