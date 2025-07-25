import 'package:anti_inflammatory_app/helpers/nullables.dart';

class HomeLevelModel {
  Level? level;
  String? points;
  String? goal;
  String? meal;
  Referrals? referrals;

  HomeLevelModel(
      {this.level,
      this.points = "0",
      this.goal = "0",
      this.meal = "0",
      this.referrals});

  HomeLevelModel.fromJson(Map<String, dynamic> json) {
    level = json['level'] != null ? Level.fromJson(json['level']) : Level();
    points = json['points'].toString().toNullString();
    goal = json['goal'].toString().toNullString();
    meal = json['meal'].toString().toNullString();
    referrals = json['referrals'] != null
        ? Referrals.fromJson(json['referrals'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (level != null) {
      data['level'] = level!.toJson();
    }
    data['points'] = points;
    data['goal'] = goal;
    data['meal'] = meal;
    if (referrals != null) {
      data['referrals'] = referrals!.toJson();
    }
    return data;
  }
}

class Level {
  int current = 0;
  int next = 0;
  int needed = 0;

  Level({this.current = 0, this.next = 0, this.needed = 0});

  Level.fromJson(Map<String, dynamic> json) {
    current = int.parse(json['current']).toNullInt();
    next = int.parse(json['next']).toNullInt();
    needed = int.parse(json['needed']).toNullInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current'] = current;
    data['next'] = next;
    data['needed'] = needed;
    return data;
  }
}

class Referrals {
  int? used;
  int? total;

  Referrals({this.used = 0, this.total = 0});

  Referrals.fromJson(Map<String, dynamic> json) {
    used = json['used'] as int?;
    total = json['total'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['used'] = used;
    data['total'] = total;
    return data;
  }
}
