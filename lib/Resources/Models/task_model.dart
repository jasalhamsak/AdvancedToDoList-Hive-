import 'package:flutter/material.dart'; // required for TimeOfDay
import 'package:hive/hive.dart';
import 'category_model.dart';

part 'task_model.g.dart';

@HiveType(typeId: 2)
class TaskModel extends HiveObject {
  @HiveField(0)
  String label;

  @HiveField(1)
  Category category;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  String time; // Example: "14:30"

  @HiveField(4)
  bool isStrikeOff;

  @HiveField(5) // ✅ New field for task type
  int taskType;

  TaskModel({
    required this.label,
    required this.category,
    required this.date,
    required this.time,
    this.isStrikeOff = false,
    this.taskType = 0, // Default type
  });
}
