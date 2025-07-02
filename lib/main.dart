import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todolist/presentation/MainScreen/components/MainScreen.dart';
import 'package:todolist/presentation/MainScreen/cubit/main_cubit.dart';

import 'Resources/Models/category_model.dart';
import 'Resources/Models/task_model.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(TaskModelAdapter());

  var box = await Hive.openBox<TaskModel>('taskbox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),     // mandatory
      themeMode: ThemeMode.dark,
      home: BlocProvider(
        create: (context) => MainCubit()..init(),
        child: Mainscreen(),
      ),
    );
  }
}
