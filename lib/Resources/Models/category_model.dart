
import 'package:hive/hive.dart';

part 'category_model.g.dart'; // this will be generated

@HiveType(typeId: 1)
class Category extends HiveObject {
  @HiveField(0)
  String category;

  @HiveField(1)
  String color;

  @HiveField(2)
  String iconName; // 👈 store icon name like 'luggage', 'heart', etc.

  Category({
    required this.category,
    required this.color,
    required this.iconName,
  });
}
