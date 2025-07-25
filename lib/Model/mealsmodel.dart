// import 'package:anti_inflammatory_app/helpers/nullables.dart';

// class MealModel {
//   MealModel({
//     this.meal = Meal(
//       recipe: Recipe(
//         createdAt: "",
//         updatedAt: "",
//         createdBy: "",
//         id: "",
//       ),
//       type: "",
//       recipeType: "",
//     ),
//     this.id = "",
//     this.createdBy = "",
//     this.date = "",
//     this.createdAt = "",
//     this.updatedAt = "",
//     this.v = "",
//   });

//   Meal meal;
//   String id;
//   String createdBy;
//   String date;
//   String createdAt;
//   String updatedAt;
//   String v;

//   factory MealModel.fromJson(Map<String, dynamic> json) => MealModel(
//         meal: Meal.fromJson(json["meal"] ?? const {}),
//         id: json["_id"]?.toString() ?? "",
//         createdBy: json["createdBy"]?.toString() ?? "",
//         date: json["date"]?.toString() ?? "",
//         createdAt: json["createdAt"]?.toString() ?? "",
//         updatedAt: json["updatedAt"]?.toString() ?? "",
//         v: json["__v"]?.toString() ?? "",
//       );
// }

// class Meal {
//   Meal({
//     this.type = "",
//     this.recipeType = "",
//     this.recipe = Recipe(
//       createdAt: "",
//       updatedAt: "",
//       createdBy: "",
//       id: "",
//     ),
//   });

//   String type;
//   String recipeType;
//   Recipe recipe;

//   factory Meal.fromJson(Map<String, dynamic> json) => Meal(
//         type: json["type"]?.toString() ?? "",
//         recipeType: json["recipeType"]?.toString() ?? "",
//         recipe: Recipe.fromJson(json["recipe"] ?? const {}),
//       );
// }

// class Recipe {
//   Recipe({
//     this.id = "",
//     this.name = "",
//     this.ingredients = const [],
//     this.createdBy = "",
//     this.preparationSteps = const [],
//     this.purchaseType = "",
//     this.image = "",
//     this.createdAt,
//     this.updatedAt,
//     this.v = "0",
//   });

//   String id;
//   String name;
//   List<Ingredient> ingredients;
//   String createdBy;
//   List<PreparationStep> preparationSteps;
//   String purchaseType;
//   String image;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   String v;

//   factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
//         id: json["_id"]?.toString() ?? "",
//         name: json["name"]?.toString() ?? "",
//         ingredients: List<Ingredient>.from(
//             json["ingredients"]?.cast<Map<String, dynamic>>() ?? const []),
//         createdBy: json["createdBy"]?.toString() ?? "",
//         preparationSteps: List<PreparationStep>.from(
//             json["preparationSteps"]?.cast<Map<String, dynamic>>() ?? const []),
//         purchaseType: json["purchaseType"]?.toString() ?? "",
//         image: json["image"]?.toString() ?? "",
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.parse(json["updatedAt"]),
//         v: json["__v"]?.toString() ?? "0",
//       );
// }

// class Ingredient {
//   Ingredient({
//     this.ingredient = IngredientModel(
//       id: "",
//       name: "",
//       category: "",
//       kcal: "0",
//       protein: "0.0",
//       fats: "0.0",
//       carbs: "0.0",
//       v: "0",
//     ),
//     this.quantity = 0,
//     this.id = "",
//   });

//   IngredientModel ingredient;
//   int quantity;
//   String id;

//   factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
//         ingredient: IngredientModel.fromJson(json["ingredient"] ?? const {}),
//         quantity: json["quantity"]?.toInt() ?? 0,
//         id: json["_id"]?.toString() ?? "",
//       );
// }

// class IngredientModel {
//   IngredientModel({
//     this.id = "",
//     this.name = "",
//     this.category = "",
//     this.kcal = "0",
//     this.protein = "0.0",
//     this.fats = "0.0",
//     this.carbs = "0.0",
//     this.v = "0",
//   });

//   String id;
//   String name;
//   String category;
//   String kcal;
//   String protein;
//   String fats;
//   String carbs;
//   String v;

//   factory IngredientModel.fromJson(Map<String, dynamic> json) =>
//       IngredientModel(
//         id: json["_id"]?.toString() ?? "",
//         name: json["name"]?.toString() ?? "",
//         category: json["category"]?.toString() ?? "",
//         kcal: json["kcal"]?.toString().toNullString() ?? "0",
//         protein: json["protein"]?.toString().toNullString() ?? "0.0",
//         fats: json["fats"]?.toString().toNullString() ?? "0.0",
//         carbs: json["carbs"]?.toString().toNullString() ?? "0.0",
//         v: json["__v"]?.toString().toNullString() ?? "0",
//       );
// }

// class PreparationStep {
//   PreparationStep({
//     this.title = "",
//     this.points = const [],
//     this.id = "",
//   });

//   String title;
//   List<String> points;
//   String id;

//   factory PreparationStep.fromJson(Map<String, dynamic> json) =>
//       PreparationStep(
//         title: json["title"]?.toString() ?? "",
//         points: List<String>.from(json["points"]?.cast<String>() ?? const []),
//         id: json["_id"]?.toString() ?? "",
//       );
// }

import 'package:anti_inflammatory_app/helpers/nullables.dart';

class MealsModel {
  Meal? meal;
  String? sId;
  String? createdBy;
  String? date;
  String? createdAt;
  String? updatedAt;
  String? iV;

  MealsModel(
      {this.meal,
      this.sId,
      this.createdBy,
      this.date,
      this.createdAt,
      this.updatedAt,
      this.iV});

  MealsModel.fromJson(Map<String, dynamic> json) {
    meal = json['meal'] != null ? Meal.fromJson(json['meal']) : null;
    sId = json['_id'].toString().toNullString();
    createdBy = json['createdBy'].toString().toNullString();
    date = json['date'].toString().toNullString();
    createdAt = json['createdAt'].toString().toNullString();
    updatedAt = json['updatedAt'].toString().toNullString();
    iV = json['__v'].toString().toNullString();
  }
}

class Meal {
  String? type;
  String? recipeType;
  Recipe? recipe;

  Meal({this.type, this.recipeType, this.recipe});

  Meal.fromJson(Map<String, dynamic> json) {
    type = json['type'].toString().toNullString();
    recipeType = json['recipeType'].toString().toNullString();
    recipe = json['recipe'] != null ? Recipe.fromJson(json['recipe']) : null;
  }
}

class Recipe {
  String? sId;
  String? name;
  List<Ingredients>? ingredients;
  String? createdBy;
  List<PreparationSteps>? preparationSteps;
  String? purchaseType;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? iV;

  Recipe(
      {this.sId,
      this.name,
      this.ingredients,
      this.createdBy,
      this.preparationSteps,
      this.purchaseType,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Recipe.fromJson(Map<String, dynamic> json) {
    sId = json['_id'].toString().toNullString();
    name = json['name'].toString().toNullString();
    if (json['ingredients'] != null) {
      ingredients = <Ingredients>[];
      json['ingredients'].forEach((v) {
        ingredients!.add(Ingredients.fromJson(v));
      });
    }
    createdBy = json['createdBy'].toString().toNullString();
    if (json['preparationSteps'] != null) {
      preparationSteps = <PreparationSteps>[];
      json['preparationSteps'].forEach((v) {
        preparationSteps!.add(PreparationSteps.fromJson(v));
      });
    }
    purchaseType = json['purchaseType'].toString().toNullString();
    image = json['image'].toString().toNullString();
    createdAt = json['createdAt'].toString().toNullString();
    updatedAt = json['updatedAt'].toString().toNullString();
    iV = json['__v'];
  }
}

class Ingredients {
  Ingredient? ingredient;
  String? quantity;
  String? sId;

  Ingredients({this.ingredient, this.quantity, this.sId});

  Ingredients.fromJson(Map<String, dynamic> json) {
    ingredient = json['ingredient'] != null
        ? Ingredient.fromJson(json['ingredient'])
        : null;
    quantity = json['quantity'];
    sId = json['_id'];
  }
}

class Ingredient {
  String? sId;
  String? name;
  String? category;
  String? kcal;
  String? protein;
  String? fats;
  String? carbs;
  String? iV;
  String? unit;

  Ingredient(
      {this.sId,
      this.name,
      this.category,
      this.kcal,
      this.protein,
      this.fats,
      this.carbs,
      this.iV,
      this.unit});

  Ingredient.fromJson(Map<String, dynamic> json) {
    sId = json['_id'].toString().toNullString();
    name = json['name'].toString().toNullString();
    category = json['category'].toString().toNullString();
    kcal = json['kcal'].toString().toNullString();
    protein = json['protein'].toString().toNullString();
    fats = json['fats'].toString().toNullString();
    carbs = json['carbs'].toString().toNullString();
    iV = json['__v'].toString().toNullString();
    unit = json['unit'].toString().toNullString();
  }
}

class PreparationSteps {
  String? title;
  List<String>? points;
  String? sId;

  PreparationSteps({this.title, this.points, this.sId});

  PreparationSteps.fromJson(Map<String, dynamic> json) {
    title = json['title'].toString().toNullString();
    points = json['points'].cast<String>();
    sId = json['_id'].toString().toNullString();
  }
}
