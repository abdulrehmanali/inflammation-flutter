import 'package:anti_inflammatory_app/helpers/nullables.dart';

class FlareModel {
  String id;
  DateTime date;
  String sovereignty;
  String createdBy;
  String notes;
  String createdAt;
  String updatedAt;
  String v;

  FlareModel({
    required this.id,
    required this.date,
    required this.sovereignty,
    required this.createdBy,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory FlareModel.fromJson(Map<String, dynamic> json) => FlareModel(
        id: json["_id"].toString().toNullString(),
        date: DateTime.parse(json["date"].toString().toNullString()),
        sovereignty: json["sovereignty"].toString().toNullString(),
        createdBy: json["createdBy"].toString().toNullString(),
        notes: json["notes"].toString().toNullString(),
        createdAt: json["createdAt"].toString().toNullString(),
        updatedAt: json["updatedAt"].toString().toNullString(),
        v: json["__v"].toString().toNullString(),
      );
}

class CreatedBy {
  String id;
  String name;

  CreatedBy({
    required this.id,
    required this.name,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json["_id"],
        name: json["name"],
      );
}
