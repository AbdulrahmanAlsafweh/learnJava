import 'package:flutter/material.dart';
import 'home.dart';
import 'signup.dart';
import 'login.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'lesson.dart';
void main() {
  runApp(const MyApp());
}

Future<bool> checkIfLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool loggedIn = prefs.getBool('loggedin') ?? false;
  return loggedIn;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkIfLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Future hasn't completed yet, show loading indicator or splash screen
          return MaterialApp(

            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          // Handle error
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Error occurred: ${snapshot.error}'),
              ),
            ),
          );
        } else {
          // Future completed, check if user is logged in
          bool isLoggedIn = snapshot.data ?? false;
          return MaterialApp(
            theme: ThemeData(
              primaryColor: Color(0xFFFEE57B),
            ),
            home: isLoggedIn ? Home() : Login(),
          );
        }
      },
    );
  }
}
