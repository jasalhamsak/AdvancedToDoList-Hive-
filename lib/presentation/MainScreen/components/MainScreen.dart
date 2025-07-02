import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/presentation/MainScreen/Resources/Pages/AddTaskPage/Components/AddPage.dart';
import 'package:todolist/presentation/MainScreen/Resources/Pages/SettingsScreen/components/SettingsPage.dart';
import 'package:todolist/presentation/MainScreen/cubit/main_cubit.dart';
import '../../../Resources/BottonNavBar.dart';
import '../Resources/Pages/HomeScreen/Components/HomePage.dart';

class Mainscreen extends StatelessWidget {
  const Mainscreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(builder: (context, state) {
      final cubit = context.read<MainCubit>();
      return SafeArea(
        child: Scaffold(
          extendBody: true,
          body: SizedBox.expand(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 0.0, 0.5, 1.0],
                  colors: [
                    Color(0xFF6C56F9),  // Purple highlight at top
                    Color(0xFF2B284B),  // Deep indigo transition
                    Color(0xFF1E1F25),  // Main dark background
                    Color(0xFF1A1B21),  // Deep black/navy at bottom
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0,right: 25),
                child: SafeArea(
                    child: cubit.selectedIndex == 0
                        ? HomePage(colorList: cubit.categoryColors,)
                        : cubit.selectedIndex == 1
                        ? Addpage()
                        : cubit.selectedIndex == 2?Settingspage(action: (){cubit.switchPage(0);}):SizedBox()
                ),
              ),
            ),
          ),
          bottomNavigationBar: cubit.selectedIndex == 0
              ? Material(
            color: Colors.transparent, // So your CustomNavBar's own color shows
            elevation: 10, // Shadow
            child: CustomNavBar(),
          )
              : null,
        ),
      );
    });
  }
}
