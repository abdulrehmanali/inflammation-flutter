class RecipeModel {
  String? id;
  String? name;
  List<IngredientModel>? ingredients;
  CreatedByModel? createdBy;
  List<PreparationStepModel>? preparationSteps;
  double? price;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? v;

  RecipeModel(
      {this.id,
      this.name,
      this.ingredients,
      this.createdBy,
      this.preparationSteps,
      this.price,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.v});

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['_id'],
      name: json['name'],
      ingredients: json['ingredients'] != null
          ? (json['ingredients'] as List)
              .map<IngredientModel>((json) => IngredientModel.fromJson(json))
              .toList()
          : null,
      createdBy: json['createdBy'] != null
          ? CreatedByModel.fromJson(json['createdBy'])
          : null,
      preparationSteps: json['preparationSteps'] != null
          ? (json['preparationSteps'] as List)
              .map<PreparationStepModel>(
                  (json) => PreparationStepModel.fromJson(json))
              .toList()
          : null,
      price: json['price'],
      image: json['image'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }
}

class IngredientModel {
  String? id;
  IngredientSubModel? ingredient;
  int? quantity;

  IngredientModel({this.id, this.ingredient, this.quantity});

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(
      id: json['id'],
      ingredient: json['ingredient'] != null
          ? IngredientSubModel.fromJson(json['ingredient'])
          : null,
      quantity: json['quantity'],
    );
  }
}

class IngredientSubModel {
  String? id;
  String? name;
  String? category;

  IngredientSubModel({this.id, this.name, this.category});

  factory IngredientSubModel.fromJson(Map<String, dynamic> json) {
    return IngredientSubModel(
      id: json['id'],
      name: json['name'],
      category: json['category'],
    );
  }
}

class CreatedByModel {
  String? id;
  String? name;
  String? email;

  CreatedByModel({this.id, this.name, this.email});

  factory CreatedByModel.fromJson(Map<String, dynamic> json) {
    return CreatedByModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}

class PreparationStepModel {
  String? id;
  String? title;
  List<String>? points;

  PreparationStepModel({this.id, this.title, this.points});

  factory PreparationStepModel.fromJson(Map<String, dynamic> json) {
    return PreparationStepModel(
      id: json['id'],
      title: json['title'],
      points: json['points'] != null
          ? (json['points'] as List).cast<String>().toList()
          : null,
    );
  }
}
