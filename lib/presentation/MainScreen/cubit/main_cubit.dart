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
  Category selectedCategory =Category(category: 'travel', color: 'red', iconName: 'luggage');

  final Map<String, Color> colorMap = {
    'red': Colors.red,
    'green': Colors.green,
    'blue': Colors.blue,
    'orange': Colors.orange,
    'pink': Colors.pink,
    'teal': Colors.teal,
    'purple': Colors.purple,
    'indigo': Colors.indigo,
    'amber': Colors.amber,
    'cyan': Colors.cyan,
    'grey': Colors.grey,
    'black': Colors.black,
    'white': Colors.white,
    // add more if needed
  };


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

  final List<Category> defaultCategories = [
    Category(category: 'Travel', color: 'red', iconName: 'luggage'),
    Category(category: 'Fitness', color: 'green', iconName: 'dumbbell'),
    Category(category: 'Study', color: 'blue', iconName: 'book'),
    Category(category: 'Shopping', color: 'orange', iconName: 'shoppingBag'),
    Category(category: 'Health', color: 'pink', iconName: 'heart'),
  ];





  late Box<TaskModel> _myBox;
  late Box<Category> _categoryBox;
  List<dynamic> get keys => _myBox.keys.toList();
  List<dynamic> get values => _myBox.values.toList();
  List<dynamic> getCategoryKeys() => _categoryBox.keys.toList();

  List result = [];
  int counter = 1;
  SharedPreferences? prefs;
  bool isStrike = false;



//initializing all box,shared preference starts
  Future<void> init() async {
     _myBox = Hive.box('taskbox');
     _categoryBox =Hive.box<Category>('categoryBox');
    prefs = await SharedPreferences.getInstance();
     if (_categoryBox.isEmpty) {
       for (var cat in defaultCategories) {
         _categoryBox.add(cat);
       }
     }
    counter = getPrefs() ?? 1;
    readData();
    print("Counter loaded: $counter");
  }

  //category management

  void addCategory(Category category) {
    final exists = _categoryBox.values.any(
          (c) => c.category.toLowerCase().trim() == category.category.toLowerCase().trim(),
    );

    if (!exists) {
      _categoryBox.add(category);
      emit(CategoryListUpdated());
    } else {
      // Optional: Emit a separate state or show error message
      emit(CategoryAlreadyExists());
    }
  }

  void removeCategoryByKey(dynamic key) {
    _categoryBox.delete(key);
    emit(CategoryListUpdated());
  }

  void taskSelectCategory(Category category){
    selectedCategory =category;
    emit(CategoryAdded());
  }


  List<Category> getCategories() {
    return _categoryBox.values.toList();
  }

  void resetCategoriesToDefault() {
    _categoryBox.clear();
    for (var cat in defaultCategories) {
      _categoryBox.add(cat);
    }
    emit(CategoryListUpdated());
  }

  Color getColor(String color) =>
      colorMap[color.toLowerCase()] ?? Colors.grey;


  String selectedCategoryColor = 'red'; // default
  String selectedCategoryIcon = 'daily'; // default

  void changeSelectedCategoryColor(String color) {
    selectedCategoryColor = color;
    emit(CategoryColorChanged()); // emit state to rebuild UI
  }
  void changeSelectedCategoryIcon(String iconName) {
    selectedCategoryIcon = iconName;
    emit(CategoryIconChanged()); // or your custom state
  }

  //convert stored icon into usable icon
  IconData getLucideIcon(String name) {
    return lucideIconMap[name] ?? LucideIcons.newspaper;
    //   Icon(getLucideIcon('apple')); // shows apple icon
  }


  void chooseCategory(){
    selectedCategory = Category(category: 'travel', color: 'red', iconName: 'luggage');
  }
  ///category management ends





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
  void writeData(String textItem ,BuildContext context,{bool isStrikeOff = false}) {
    if(textItem.isEmpty){
      return;
    }

    // final category = Category(category: 'travel', color: 'red', iconName: 'luggage');
    final task = TaskModel(
      label: textItem,
      category: selectedCategory,
      date: selectedDate?? DateTime.now(),
      time: selectedTime != null ? selectedTime!.format(context) : "7:00 am",
      taskType: taskType, // Example: 1 = Study
    );

    _myBox.put(counter, task);

    print(counter);
    counter++;
    print(counter);
    setPrefs(counter);
    readData();
    selectedDate = null;
    selectedTime = null;
    taskType = 0;
    selectedCategory = Category(category: 'travel', color: 'red', iconName: 'luggage');
    selectedCategoryColor = 'red';
    selectedCategoryIcon = 'luggage';
    emit(ValueAdded());
    selectedIndex = 0;
    emit(PageSwitched());
  }






  void readData() {
    result = _myBox.values.toList();
    for (var task in result) {
      print('🔹 Label      : ${task.label}');
      print('📅 Date       : ${task.date}');
      print('⏰ Time       : ${task.time}');
      print('📌 Type       : ${task.taskType}');
      print('❌ StrikeOff  : ${task.isStrikeOff}');
      print('📂 Category   : ${task.category.category}');
      print('🎨 Color      : ${task.category.color}');
      print('📎 Icon Name  : ${task.category.iconName}');
      print('-------------------------------');
    }
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
