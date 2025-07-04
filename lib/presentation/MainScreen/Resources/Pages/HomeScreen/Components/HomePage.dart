import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:todolist/presentation/MainScreen/cubit/main_cubit.dart'; // ✅ Update import

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        final cubit = context.read<MainCubit>();
        final tasks = cubit.values; // ✅ real tasks from Hive box
        final keys = cubit.keys;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              "Today's Schedule",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            const Text(
              "Monday 19",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.deepPurple,
              ),
            ),
            Expanded(
              child: tasks.isEmpty
                  ? const Center(
                child: Text("No tasks yet",
                    style: TextStyle(color: Colors.grey)),
              )
                  : ListView.builder(
                itemCount: tasks.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  final color = cubit.getColor(task.category.color);
                  final icon = cubit.getLucideIcon(task.category.iconName);
                  final key = keys[index];

                  return GestureDetector(
                    onTap: (){
                      cubit.toggleStrike(key);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          task.isStrikeOff
                              ? LucideIcons.square_check_big
                              : LucideIcons.square,
                          color: task.isStrikeOff
                              ?Colors.green: Colors.grey,
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xff2a2e3d),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: color,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  margin: const EdgeInsets.all(15),
                                  padding: const EdgeInsets.all(5),
                                  child: Icon(
                                    icon,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    task.label,
                                    overflow: TextOverflow.visible,
                                    maxLines: null,
                                    style: TextStyle(
                                      color: task.isStrikeOff ? Colors.grey[500] : Colors.white,
                                      fontWeight: FontWeight.bold,
                                      decoration: task.isStrikeOff
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                    ),
                                  ),

                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    task.time,
                                    style:
                                    const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 25),
          ],
        );
      },
    );
  }
}
