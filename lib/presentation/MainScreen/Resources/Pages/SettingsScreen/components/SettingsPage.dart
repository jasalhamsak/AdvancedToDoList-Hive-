import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/presentation/MainScreen/cubit/main_cubit.dart';

import '../../../../../../Resources/HeadingStyles.dart';
import '../../../../../../Resources/Models/category_model.dart';

class Settingspage extends StatelessWidget {
  Settingspage({super.key, required this.action});

  final VoidCallback action;
  static final TextEditingController addController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        final cubit = context.read<MainCubit>();
        final categories = cubit.getCategories();
        final keys = cubit.getCategoryKeys();
        return SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: () {
                    action!();
                  },
                  child: Icon(Icons.chevron_left)),
              Headingstyles(data: "Settings", typeH123: "H1"),
              TextFormField(
                controller: addController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hintText: "Add category"),
              ),
              SizedBox(height: 20,),
              /// 🔵 Color Picker Section (inside build)
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: cubit.colorMap.keys.map((colorName) {
                  final color = cubit.getColor(colorName);
                  final isSelected = cubit.selectedCategoryColor == colorName;

                  return GestureDetector(
                    onTap: () {
                      cubit.changeSelectedCategoryColor(colorName);
                    },
                    child: CircleAvatar(
                      radius: isSelected ? 18 : 16,
                      backgroundColor: color,
                      child: isSelected
                          ? Icon(Icons.check, size: 18, color:color==Colors.white? Colors.black:Colors.white)
                          : null,
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20,),

              ElevatedButton.icon(
                onPressed: () {
                  final text = addController.text.trim();
                  if (text.isNotEmpty) {
                    final newCategory = Category(
                      category: text,
                      color: cubit.selectedCategoryColor,
                      iconName: 'luggage',
                    );
                    cubit.addCategory(newCategory);
                    addController.clear(); // optional: clear the input
                  } else {
                    // Optional: show a SnackBar or message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            Icon(Icons.warning_amber_rounded,
                                color: Colors.white),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "Please enter a category name",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        backgroundColor: Colors.deepPurple,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: EdgeInsets.all(16),
                        duration: Duration(seconds: 3),
                        elevation: 6,
                      ),
                    );
                  }
                },
                icon: Icon(Icons.add),
                label: Text("Add Category"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Wrap(
                spacing: 15,
                runSpacing: 10,
                children: List.generate(categories.length, (index) {
                  final key = keys[index];

                  return IntrinsicWidth(
                    child: Container(
                      decoration: BoxDecoration(
                        color: cubit.getColor(categories[index].color),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(categories[index].category),
                            IconButton(
                                onPressed: () {
                                  cubit.removeCategoryByKey(key);
                                },
                                icon: Icon(Icons.clear))
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
