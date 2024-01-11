import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home.dart';

class AddLesson extends StatefulWidget {
  const AddLesson({super.key});

  @override
  State<AddLesson> createState() => _AddLessonState();
}

Future<void> addNewLesson(lessonName,lessonDesc,lessonContent) async {
  var url = 'https://learnjavaliu.000webhostapp.com/addLesson.php';

  // try {
    var response = await http.post(
      Uri.parse(url),
      body: {
        'LessonName': lessonName,
        'LessonDesc': lessonDesc,
        'LessonContent' : lessonContent,
      },
    );
}

class _AddLessonState extends State<AddLesson> {
  String LessonName='';
  String LessonDesc='';
  String LessonContent='';

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(title: Text(
          "New Lesson"
        ),
        backgroundColor: Colors.grey,),
        body:
        Column(

          children: [
              SizedBox(height: 30,),
            TextField(
              onChanged: (value) {
                setState(() {
                  LessonName = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Lesson Name',
                filled: true,
                fillColor: Colors.grey[800],
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              onChanged: (value) {
                setState(() {
                  LessonDesc = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Description',
                filled: true,
                fillColor: Colors.grey[800],
              ),
            ),

            SizedBox(height: 20,),
            TextField(
              onChanged: (value) {
                setState(() {
                  LessonContent = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Content',
                filled: true,
                fillColor: Colors.grey[800],
              ),
            ),

            SizedBox(height: 40,),
            ElevatedButton(onPressed: () {
              addNewLesson(LessonName,LessonDesc,LessonContent);
              if(LessonName.isNotEmpty && LessonContent.isNotEmpty && LessonContent.isNotEmpty)
              Navigator.pop(context);
            }, child:Text(
              "Add New Lesson"
            ))
          ],
        ),
      );

  }
}

