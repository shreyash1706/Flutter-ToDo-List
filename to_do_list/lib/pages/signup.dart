import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/auth_services/firebase_auth_servies.dart';
import 'package:to_do_list/pages/app.dart';



class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final FireBaseAuthServices _auth =FireBaseAuthServices();
  
  TextEditingController _usernamecontroller =TextEditingController();
  TextEditingController _emailcontroller =TextEditingController();
  TextEditingController _passwordcontroller =TextEditingController();
  TextEditingController _namecontroller =TextEditingController();
  TextEditingController _agecontroller =TextEditingController();

  @override
  void dispose() {
    _usernamecontroller.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _agecontroller.dispose();
    _namecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Define custom color using RGB values
    // Color customColor = Color.fromARGB(255, 31, 115, 184);

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              controller: _namecontroller,
              decoration: InputDecoration(
                labelText: 'Name',
                // border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _usernamecontroller,
              decoration: InputDecoration(
                labelText: 'Username',
                // border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _emailcontroller,
              decoration: InputDecoration(
                labelText: 'Email',
                // border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordcontroller,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                
                // border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _agecontroller,
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
                _signup() ;// Add your authentication logic here
              },
              style: ElevatedButton.styleFrom(
                // backgroundColor: customColor, // Use custom color
              ),
              child: Text('Sign up'),
            ),
          ],
        ),
      ),
    );
  }
  void _signup() async{
  String username = _usernamecontroller.text;
  String email = _emailcontroller.text;
  String password = _passwordcontroller.text;
  String name = _namecontroller.text;
  String age = _agecontroller.text;


  User? user = await _auth.signUpWithEmailAndPassword(email, password);

  if(user!=null){
    print("User successfully created");
    FirebaseFirestore.instance.collection('Users').doc(user.uid).set({
      "username": username,
      "email": email,
      "name": name,
      "age": age
    });
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
  }else{
    print("some error happened");
  }
}
}


