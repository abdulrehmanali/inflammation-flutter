class RecipeModel {
  final String id;
  final String name;
  final List<Ingredient> ingredients;
  final User createdBy;
  final List<PreparationStep> preparationSteps;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;

  RecipeModel({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.createdBy,
    required this.preparationSteps,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['_id'],
      name: json['name'],
      ingredients: (json['ingredients'] as List)
          .map((s) => Ingredient.fromJson(s))
          .toList(),
      createdBy: User.fromJson(json['createdBy']),
      preparationSteps: (json['preparationSteps'] as List)
          .map((s) => PreparationStep.fromJson(s))
          .toList(),
      image: json['image'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class Ingredient {
  final String id;
  final IngredientDetail ingredient;
  final String quantity;

  Ingredient({
    required this.id,
    required this.ingredient,
    required this.quantity,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['_id'],
      ingredient: IngredientDetail.fromJson(json['ingredient']),
      quantity: json['quantity'],
    );
  }
}

class IngredientDetail {
  final String name;
  final String category;

  IngredientDetail({
    required this.name,
    required this.category,
  });

  factory IngredientDetail.fromJson(Map<String, dynamic> json) {
    return IngredientDetail(
      name: json['name'],
      category: json['category'],
    );
  }
}

class User {
  final String name;
  final String email;

  User({
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
    );
  }
}

class PreparationStep {
  final String id;
  final String title;
  final List<String> points;

  PreparationStep({
    required this.id,
    required this.title,
    required this.points,
  });

  factory PreparationStep.fromJson(Map<String, dynamic> json) {
    return PreparationStep(
      id: json['_id'],
      title: json['title'],
      points: List<String>.from(json['points']),
    );
  }
}
