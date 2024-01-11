import 'package:flutter/material.dart';
import 'addlesson.dart';
import 'addExercise.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Administration"),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 30,),
          Expanded(
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                child: Text("Add New Lesson"),
                style: ElevatedButton.styleFrom(
                    primary: Color(0xFF368181)
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddLesson()),
                  );
                },
              ),
            ),
            flex: 2,
          ),
          SizedBox(height: 30,),

          SizedBox(height: 30,)
        ],
      ),
    );
  }
}
