import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Headingstyles extends StatelessWidget {
  const Headingstyles({super.key, required this.data, required this.typeH123});

 final String data;
 final String typeH123 ;

  @override
  Widget build(BuildContext context) {

    final TextStyle h1 =TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 30,
        color: Colors.white);

    final TextStyle h2 =TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold);

    final TextStyle h3 =TextStyle(
        color: Colors.white,);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Text(data,style: typeH123 =="H2"?h2:typeH123 =="H3"?h3:h1),
    );
  }
}
