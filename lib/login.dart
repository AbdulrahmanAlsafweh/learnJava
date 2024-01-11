import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learnjava/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'home.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

Future<void> Makelogin(username, password, BuildContext context) async {
  var url = 'https://learnjavaliu.000webhostapp.com/login.php';

  try {
    var response = await http.post(
      Uri.parse(url),
      body: {
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse['success']) {
        String role = jsonResponse['role'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('userRole', role);
        prefs.setString('username', username);
        prefs.setBool('loggedin', true);

        // Use Navigator.push instead of Navigator.of(context).push
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      } else {
        String errorMessage = jsonResponse['message'];
        // Handle the error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      throw Exception('Failed to load data');
    }
  } catch (error) {
    print('Error: $error');
    // Show a generic error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('An error occurred'),
        backgroundColor: Colors.red,
      ),
    );
  }
}

class _LoginState extends State<Login> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {

    return
    MaterialApp(
        theme: ThemeData.dark().copyWith(
          primaryColor: Color(0xFF368181), // Your primary color
          scaffoldBackgroundColor: Colors.grey[900], // Your background color
        ),
      home:  Scaffold(
          appBar: AppBar(
            title: Text("Login"),
            actions:  [
              Center(
                child:
                InkWell(
                  child: Text("Sign Up"),
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignUp(),));
                  },
                ),

              )
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  onChanged: (value) {
                    setState(() {
                      username = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Username',
                    filled: true,
                    fillColor: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    filled: true,
                    fillColor: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Makelogin(username, password, context),
                  child: Text("Login"),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF368181), )
                ),
              ],
            ),
          ),
        )
    );


  }
}
