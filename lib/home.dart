import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'lesson.dart';
import 'lessonDetails.dart';
import 'login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'lessonDesc.dart';
import 'adminPage.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

Future<String> checkIfAdmin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String isAdmin = prefs.getString('userRole') as String;
  return isAdmin;
}

class _HomeState extends State<Home> {
  bool isAdmin = false; // Define isAdmin variable

  @override
  void initState() {
    super.initState();
    checkAdminStatus();
    getLessons();
  }

  Future<void> checkAdminStatus() async {
    String userRole = await checkIfAdmin();
    setState(() {
      isAdmin = userRole == '1';
    });
  }

  Future<void> deleteLesson(lessonName) async {
    var url = 'https://learnjavaliu.000webhostapp.com/deleteLesson.php';
    var response = await http.post(Uri.parse(url), body: {
      'lessonName': lessonName,
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse['success']) {
        getLessons();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Lesson deleted"),
            backgroundColor: Colors.green, // or another color for success
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to delete lesson"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to delete lesson"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  Future<void> getLessons() async {
    List<Lesson> lessonsList = [];

    var url = 'https://learnjavaliu.000webhostapp.com/get_lessons.php';
    var response = await http.post(Uri.parse(url), body: {});

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);

      for (var lessonData in jsonResponse) {
        lessonsList.add(
          Lesson(
            name: lessonData['name'] ?? '',
            description: lessonData['description'] ?? '',
            content: lessonData['content'] ?? '',
            summary: lessonData['summary'] ?? '',
          ),
        );
      }
    } else {
      // Handle error
      log('Failed to load lessons: ${response.statusCode}');
    }

    setState(() {
      lessons = lessonsList;
    });
  }

  @override
  Widget build(BuildContext context) {
    getLessons();
    return
      MaterialApp(
          theme: ThemeData.dark().copyWith(
            primaryColor: Color(0xFF368181), // Your primary color
            scaffoldBackgroundColor: Colors.grey[900], // Your background color
          ),
          home:Scaffold(


            appBar: AppBar(

              title: Text('Learn Java'),
              // backgroundColor: Colors.red,
              actions: [
                InkWell(

                  child: Icon(Icons.logout_outlined),
                  onTap: () async {
                    getLessons();
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setBool('loggedin', false);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Login(),
                    ));
                  },
                ),
                isAdmin? InkWell(
                  child: Icon(Icons.add),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminPage(),));
                  },
                )
                    :Container(),
              ],

            ),
            body: Container(

              padding: EdgeInsets.all(16.0),
              // color: Color(0xFF368181),
              child: ListView.builder(
                itemCount: lessons.length,
                itemBuilder: (context, index) {
                  return InkWell(

                    onLongPress: () {
                      if(isAdmin){
                        deleteLesson(lessons[index].name);
                      }
                    },
                    onTap: () {
                      // Navigate to the details page when a lesson is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              LessonDetailsPage(lesson: lessons[index]),
                        ),
                      );
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [

                            Text(
                              lessons[index].name,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey,
                              ),
                            ),
                            Spacer(),
                            InkWell(
                                child: Icon(Icons.description_outlined,color: Colors.blueGrey,),
                                onTap:() {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => LessonDescription(desc: lessons[index].description,),));

                                }
                            )

                          ],
                        )),
                  );
                },
              ),
            ),
          )
      );

  }
}
