import 'package:flutter/material.dart';
import 'lesson.dart';
import 'lessonDesc.dart';
class LessonDetailsPage extends StatelessWidget {
  final Lesson lesson;

  const LessonDetailsPage({Key? key, required this.lesson}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: Text('Lesson Details'),
        actions: [
          InkWell(
            child: Icon(Icons.description_outlined),
            onTap:() {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LessonDescription(desc: lesson.description,),));

            })
        ],
      ),
      body: Column(
        children: [
          // Center the lesson name
          Center(
            child: Text(
               lesson.name,
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          SizedBox(height: 16.0),
          // Align the lesson description to the start (left) of the screen
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                lesson.content,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
          // Add more details as needed
        ],
      ),
    );
  }
}
