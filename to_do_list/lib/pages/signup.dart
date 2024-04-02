import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Sign Up Page',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color.fromARGB(255, 19, 33, 46),
      ),
    ),
    home: SignUpPage(),
  ));
}

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Define custom color using RGB values
    Color customColor = Color.fromARGB(255, 31, 115, 184);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sign up',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Name',
                // border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                // border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                // border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                // border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Age',
                // border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
              ),
              keyboardType: TextInputType.number, // Set keyboard type to number
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                // Add your authentication logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: customColor, // Use custom color
              ),
              child: Text('Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}
