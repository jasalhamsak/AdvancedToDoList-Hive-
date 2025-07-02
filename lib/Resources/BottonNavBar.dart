import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/presentation/MainScreen/cubit/main_cubit.dart';

class CustomNavBar extends StatelessWidget {


  const CustomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration:  BoxDecoration(
        color: Color(0xFF1A1B21),

        boxShadow: [
          BoxShadow(
            color: Color(0xFF1A1B21),
            blurRadius: 12,
            offset: Offset(0, -30), // shadow above the navbar
          ),
        ],
        // borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildTab(icon: Icons.home, index: 0),
          buildTab(icon: Icons.add_circle, index: 1),
          buildTab(icon: Icons.settings, index: 2),
        ],
      ),
    );
  }

  Widget buildTab({required IconData icon, required int index}) {


    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        final cubit = context.read<MainCubit>();
        final isSelected = cubit.selectedIndex == index;
        return GestureDetector(
          onTap: () {
            cubit.switchPage(index);
          }
          ,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.lightBlueAccent : Colors.grey,
                size: isSelected ? 30 : 24,
              ),
              const SizedBox(height: 4),
              if (isSelected)
                Container(
                  width: 15,
                  height: 3,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(30))
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
