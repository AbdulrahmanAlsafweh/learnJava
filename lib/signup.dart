import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

Future<void> insertData(username, password) async {
  var url = 'https://learnjavaliu.000webhostapp.com/insert_user.php';

  var response = await http.post(
    Uri.parse(url),
    body: {
      'username': username,
      'password': password,
    },
  );
}

class _SignUpState extends State<SignUp> {
  @override
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF368181), // Your primary color
        scaffoldBackgroundColor: Colors.grey[900], // Your background color
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('SignUp'),
          actions: [
            Center(
              child: InkWell(
                child: Text("Login"),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Login()),
                  );
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
                onPressed: () => insertData(username, password),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF368181), // Your button color
                ),
                child: Text("SignUp"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
