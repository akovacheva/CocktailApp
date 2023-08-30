import 'package:flutter/material.dart';
import 'package:cocktailapp/components/authentication_widget.dart';
import 'package:cocktailapp/ui_windows/search_window.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpWindow extends StatefulWidget {
  const SignUpWindow({super.key});

  @override
  State<SignUpWindow> createState() => _SignUpWindowState();
}

class _SignUpWindowState extends State<SignUpWindow> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/alcohol-bar-beer-beverage.jpg"),
                opacity: 0.9,
                fit: BoxFit.cover,
              )
          ),
          child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
                child: Column(
                  children: <Widget>[
                    logoWidgetSmaller("assets/images/logo.png"),
                    const SizedBox(
                      height: 20,
                    ),
                    inputField("Enter username", Icons.person_outline, false,
                        _userNameTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    inputField("Enter Email Id", Icons.person_outline, false,
                        _emailTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    inputField("Enter Password", Icons.lock_outlined, true,
                        _passwordTextController),
                    const SizedBox(
                      height: 20,
                    ),
                signInSignUpButton(context, false, () async {
                  try {
                    final userCredential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text)
                      .then((value){
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchWindow()));
                  });}
                  catch (e) {
                    print("Error occurred: $e");
                    setState(() {
                      _errorMessage = e.toString();
                    });
                  }
                }),
                    if (_errorMessage.isNotEmpty)
                      Text(
                        _errorMessage,
                        style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, backgroundColor: Colors.white70),
                      ),
                  ],
                ),
              )
          )),
    );
  }
}
