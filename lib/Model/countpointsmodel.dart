import 'package:anti_inflammatory_app/helpers/nullables.dart';

class CountPointsModel {
  CountPointsModel({this.meal = "1", this.goal = "1"});

  String meal;
  String goal;

  factory CountPointsModel.fromJson(Map<String, dynamic> json) =>
      CountPointsModel(
        meal: json["meal"].toString().toNullString(),
        goal: json["goal"].toString().toNullString(),
      );
}
