import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/Resources/HeadingStyles.dart';
import 'package:todolist/presentation/MainScreen/cubit/main_cubit.dart';

import '../../../../../../Resources/Icon&Text_Button.dart';

class Addpage extends StatelessWidget {
  const Addpage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      "Travel",
      "Fitness",
      "Study",
      "Shopping",
      "Health",
      // "Finance",
      // "Work",
      // "Music",
      // "Food",
      // "Daily"
    ];


    final TextEditingController addController = TextEditingController();



    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        final cubit = context.read<MainCubit>();
        return SingleChildScrollView(

          // padding: const EdgeInsets.only(bottom: 20),
          child: ConstrainedBox(
        constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height),
        child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10,),
                ElevatedButton(
                    onPressed: () {
                      cubit.switchPage(0);
                    },
                    child: Icon(Icons.chevron_left)),
                Headingstyles(data: "Create \nNew Task", typeH123: "H1"),
                SizedBox(height: 10),
                TextFormField(
                  controller: addController,
                  decoration: InputDecoration(
                      hintText: "Task title",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
                Headingstyles(data: "Task type", typeH123: "H2"),
                Row(
                  children: [
                    IcontextButton(
                      label: "Important",
                      value: cubit.taskType,
                      typeValue: 1,
                      action: () {
                        cubit.changeTaskType(1);
                      },
                    ),
                    IcontextButton(
                      label: "Planned",
                      value: cubit.taskType,
                      typeValue: 2,
                      action: () {
                        cubit.changeTaskType(2);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Headingstyles(data: "Choose date & time", typeH123: "H2"),
                Row(
                  children: [
                    Expanded(
                      child: TextButton.icon(
                        onPressed: () => cubit.selectDate(context),
                        icon: Icon(
                          Icons.calendar_today,
                          color: cubit.selectedDate == null
                              ? Colors.grey
                              : Colors.white,
                          size: 20,
                        ),
                        label: Text(
                          cubit.selectedDate == null
                              ? 'Pick a date'
                              : '${cubit.selectedDate!.day}-${cubit.selectedDate!.month}-${cubit.selectedDate!.year}',
                          style: TextStyle(
                              color: cubit.selectedDate == null
                                  ? Colors.grey
                                  : Colors.white),
                        ),
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            foregroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(12), // rounded corners
                              side: BorderSide(
                                  color: cubit.selectedDate == null
                                      ? Colors.grey
                                      : Color(0xff285eee)), // border color
                            ),
                            backgroundColor: cubit.selectedDate == null
                                ? Colors.transparent
                                : Color(0xff285eee)),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextButton.icon(
                        onPressed: () => cubit.selectTime(context),
                        icon: Icon(
                          Icons.access_time,
                          color: cubit.selectedTime == null
                              ? Colors.grey
                              : Colors.white,
                          size: 20,
                        ),
                        label: Text(
                          cubit.selectedTime == null
                              ? 'Pick a time'
                              : cubit.selectedTime!.format(context),
                          style: TextStyle(
                              color: cubit.selectedTime == null
                                  ? Colors.grey
                                  : Colors.white),
                        ),
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            foregroundColor: cubit.selectedTime == null
                                ? Colors.grey
                                : Color(0xff285eee),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(12), // rounded corners
                              side: BorderSide(
                                  color: cubit.selectedTime == null
                                      ? Colors.grey
                                      : Color(0xff285eee)), // border color
                            ),
                            backgroundColor: cubit.selectedTime == null
                                ? Colors.transparent
                                : Color(0xff285eee)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Headingstyles(data: "Category", typeH123: "H2"),
                Wrap(
                  spacing: 10,
                  runSpacing: 15,
                  children: List.generate(categories.length, (index) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: cubit.categoryColors[index],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(categories[index]),
                    );
                  }),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor: const WidgetStatePropertyAll(Color(0xffaa33fb)),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      foregroundColor: const WidgetStatePropertyAll(Colors.white),
                    ),
                    onPressed: () {
                      cubit.writeData(addController.text);
                      print("called");
                    },
                    child: const Text("Create Task"),
                  ),
                )


              ],
            ),
          ),
        );
      },
    );
  }
}
