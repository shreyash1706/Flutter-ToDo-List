import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/auth_services/firebase_auth_servies.dart';
import 'package:to_do_list/firebase_options.dart';
import 'package:to_do_list/logic/streak_logic.dart';
import 'package:to_do_list/pages/app.dart';
import 'package:to_do_list/pages/signup.dart';



class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final FireBaseAuthServices _auth =FireBaseAuthServices();
  
  // TextEditingController _usernamecontroller =TextEditingController();
  TextEditingController _emailcontroller =TextEditingController();
  TextEditingController _passwordcontroller =TextEditingController();

  @override
  void dispose() {
    ;
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

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
              'Login',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            // SizedBox(height: 16.0),
            // TextField(
            //   decoration: InputDecoration(
            //     labelText: 'Username',
            //     border: OutlineInputBorder(),
            //     fillColor: Colors.white,
            //     filled: true,
            //   ),
            // ),
            SizedBox(height: 16.0),
            TextField(
              controller: _emailcontroller,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordcontroller,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
              ),
              obscureText: true,
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                _signin();// Add your authentication logic here
              },
              style: ElevatedButton.styleFrom(
                // backgroundColor: customColor, // Use custom color
              ),
              child: Text('Sign In'),
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> SignUpPage()),ModalRoute.withName('/'));
              },
              child: Text(
                "Not already a user? Sign up",
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _signin() async{
  
  String email = _emailcontroller.text;
  String password = _passwordcontroller.text;

  User? user = await _auth.signInWithEmailAndPassword(email, password);

  if(user!=null){
    print("User is successfully signed in");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
  }else{
    print("some error happened");
  }
}
}
