import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Resources/Models/category_model.dart';
import '../../../Resources/Models/task_model.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  int selectedIndex = 0;
  int taskType = 0;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final List<Color> categoryColors = [
    Colors.red, // Travel
    Colors.green, // Fitness
    Colors.blue, // Study
    Colors.orange, // Shopping
    Colors.pink, // Health
    Colors.teal, // Finance
    Colors.purple, // Work
    Colors.indigo, // Music
    Colors.amber, // Food
    Colors.cyan, // DailyColors.red, // Travel
    Colors.green, // Fitness
    Colors.blue, // Study
    Colors.orange, // Shopping
    Colors.pink, // Health
    Colors.teal, // Finance
    Colors.purple, // Work
    Colors.indigo, // Music
    Colors.amber, // Food
    Colors.cyan, // Daily
  ];

  final Map<String, IconData> lucideIconMap = {
    'airplane': LucideIcons.airplay,
    'apple': LucideIcons.apple,
    'bookOpen': LucideIcons.book_open,
    'camera': LucideIcons.camera,
    'calendar': LucideIcons.calendar,
    'car': LucideIcons.car,
    'coffee': LucideIcons.coffee,
    'dumbbell': LucideIcons.dumbbell,
    'file': LucideIcons.file,
    'globe': LucideIcons.globe,
    'heart': LucideIcons.heart,
    'luggage': LucideIcons.luggage,
    'music': LucideIcons.music,
    'shoppingBag': LucideIcons.shopping_bag,
    'sun': LucideIcons.sun,
    'wallet': LucideIcons.wallet,
    'work': LucideIcons.briefcase,
    'food': LucideIcons.utensils,
    'gamepad': LucideIcons.gamepad,
    'study': LucideIcons.book,
    'fitness': LucideIcons.dumbbell,
    'health': LucideIcons.heart_pulse,
    'travel': LucideIcons.plane,
    'finance': LucideIcons.wallet,
    'daily': LucideIcons.calendar,
    // Add more if needed
  };





  late Box<TaskModel> _myBox;
  List<dynamic> get keys => _myBox.keys.toList();
  List<dynamic> get values => _myBox.values.toList();
  List result = [];
  int counter = 1;
  SharedPreferences? prefs;
  bool isStrike = false;



//shared preference starts
  Future<void> init() async {
     _myBox = Hive.box('taskbox');
    prefs = await SharedPreferences.getInstance();
    counter = getPrefs() ?? 1;
    readData();
    print("Counter loaded: $counter");
  }

  Future<void> setPrefs(int count) async {
    await prefs?.setInt("Item_Count", count);
    counter = getPrefs()!;
  }

  int? getPrefs() {
    return prefs?.getInt("Item_Count");
  }

  Future<void> remPrefs() async {
    await prefs?.remove("Item_Count");
  }
//shared preference ends




//CURD operations Starts
  void writeData(String textItem ,{bool isStrikeOff = false}) {
    if(textItem.isEmpty){
      return;
    }

    final category = Category(category: 'travel', color: 'red', iconName: 'luggage');
    final task = TaskModel(
      label: 'Do homework',
      category: category,
      date: DateTime.now(),
      time: '15:00',
      taskType: 1, // Example: 1 = Study
    );



    // Map<String,dynamic> values ={
    //   "text" : textItem,
    //   "isStrikeOff" : isStrikeOff
    // };
    //
    // _myBox.put(counter, values);
    // print(counter);
    // counter++;
    // print(counter);
    // setPrefs(counter);
    // readData();
    emit(ValueAdded());
  }

  //convert stored icon into usable icon
  IconData getLucideIcon(String name) {
    return lucideIconMap[name] ?? LucideIcons.newspaper;
  //   Icon(getLucideIcon('apple')); // shows apple icon
  }





  void readData() {
    result = _myBox.values.toList();
    emit(ValueRead());
  }

  void deleteData(value) {
    if(value == 'all'){
      _myBox.clear();
      result =[];
      setPrefs(1);
      readData();
      emit(AllValueDeleted());
    }else {
      _myBox.delete(value);
      setPrefs(counter);
      readData();
      emit(ValueDeleted());
    }
  }
//CURD operations Ends

//toggle Strike Line
  void toggleStrike(int key) {
    final currentItem = _myBox.get(key);
    if (currentItem != null) {
      final updatedItem = TaskModel(
        label: currentItem.label,
        category: currentItem.category,
        date: currentItem.date,
        time: currentItem.time,
        isStrikeOff: !currentItem.isStrikeOff, // 🔁 Toggle value
      );

      _myBox.put(key, updatedItem);
      readData();
      emit(ValueUpdated());
    }
  }






  void createTask() {
    final category = Category(category: 'travel', color: 'red', iconName: '');
    final task = TaskModel(
      label: 'Do homework',
      category: category,
      date: DateTime.now(),
      time: '15:00',
      taskType: 1, // Example: 1 = Study
    );


    // Now you can save to Hive, or emit a new state
    // Hive.box<TaskModel>('mybox').put(1, task);

    // Or emit to state if you're managing task state
    // emit(TaskCreated(task)); // example
  }




//UI logics

  void switchPage(page){
    selectedIndex = page;
    emit(PageSwitched());
  }
  void changeTaskType(type){
    taskType = type;
    emit(TaskTypeChanged());
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      selectedDate = picked;
      emit(DatePicked());
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      selectedTime = picked;
      emit(TimePicked());
    }
  }


}
