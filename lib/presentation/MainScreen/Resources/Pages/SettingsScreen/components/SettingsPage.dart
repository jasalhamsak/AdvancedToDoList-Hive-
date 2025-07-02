import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../Resources/HeadingStyles.dart';

class Settingspage extends StatelessWidget {
  const Settingspage({super.key, required this.action});

  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () {
              action!();
            },
            child: Icon(Icons.chevron_left)),
        Headingstyles(data: "Settings", typeH123: "H1"),

      ],
    );
  }
}
