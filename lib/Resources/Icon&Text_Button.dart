import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IcontextButton extends StatelessWidget {
  const IcontextButton({super.key, required this.label, required this.value, required this.typeValue, required this.action});

final String label;
final int value;
final int typeValue;
  final Function()? action;


  @override
  Widget build(BuildContext context) {
    bool isSelected = value==typeValue;
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: OutlinedButton( onPressed: action,
          style: OutlinedButton.styleFrom(
            side: isSelected?BorderSide.none: BorderSide(color: Theme.of(context).dividerColor, width: 1), // Border color & width
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Rounded corners
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Padding
            foregroundColor: isSelected?Colors.white:Colors.grey, // Text & icon color
            backgroundColor: isSelected?Color(0xff285eee):Colors.transparent, // Optional background
          ),
          child: Text(label)),
    );
  }
}
