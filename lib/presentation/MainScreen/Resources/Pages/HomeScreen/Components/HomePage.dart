import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key, });


  // final List colorList;


  @override
  Widget build(BuildContext context) {
    List tasks = [
      "wake up early",
      "do 10 push ups",
      "drink 250ml milk",
      "i am jayk , and am from calicut , and i want to become a master",
      "wake up early",
      "do 10 push ups",
      "drink 250ml milk",
      "i am jayk , and am from calicut , and i want to become a master",
      "wake up early",
      "do 10 push ups",
      "drink 250ml milk",
      "i am jayk , and am from calicut , and i want to become a master",
      "wake up early",
      "do 10 push ups",
      "drink 250ml milk",
      "i am jayk , and am from calicut , and i want to become a master",
    ];
    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          Text(
            "Today's Schedule",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.white),
          ),
          Text("Monday 19",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.deepPurple)),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      LucideIcons.square,
                      color: Colors.grey,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Color(0xff2a2e3d),
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                        //colorList[index],
                                borderRadius: BorderRadius.circular(8)
                              ),
                              margin: EdgeInsets.all(15),
                              padding: EdgeInsets.all(5),
                              child: Icon(
                                LucideIcons.luggage,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Text(
                              tasks[index],
                              overflow: TextOverflow.visible,
                              maxLines: null,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "7 AM",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: 25,)
        ],
      );

  }
}
