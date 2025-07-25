class AchieveGoalModel {
  final Goal goal;
  final String id;
  final String createdBy;
  final DateTime achievedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  AchieveGoalModel({
    required this.goal,
    required this.id,
    required this.createdBy,
    required this.achievedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory AchieveGoalModel.fromJson(Map<String, dynamic> json) {
    return AchieveGoalModel(
      goal: Goal.fromJson(json['goal']),
      id: json['_id'],
      createdBy: json['createdBy'],
      achievedAt: DateTime.parse(json['achievedAt']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'goal': goal.toJson(),
      '_id': id,
      'createdBy': createdBy,
      'achievedAt': achievedAt.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': version,
    };
  }
}

class Goal {
  final String name;
  final String objective;
  final String control;
  final int target;
  final int points;

  Goal({
    required this.name,
    required this.objective,
    required this.control,
    required this.target,
    required this.points,
  });

  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(
      name: json['name'],
      objective: json['objective'],
      control: json['control'],
      target: json['target'],
      points: json['points'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'objective': objective,
      'control': control,
      'target': target,
      'points': points,
    };
  }
}
