import 'package:flutter/material.dart';
import 'package:cocktailapp/components/authentication_widget.dart';
import 'package:cocktailapp/ui_windows/search_window.dart';

class SignUpWindow extends StatefulWidget {
  const SignUpWindow({super.key});

  @override
  State<SignUpWindow> createState() => _SignUpWindowState();
}

class _SignUpWindowState extends State<SignUpWindow> {

  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();

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
                    // firebaseUIButton(context, "Sign Up", () {
                    //   FirebaseAuth.instance
                    //       .createUserWithEmailAndPassword(
                    //       email: _emailTextController.text,
                    //       password: _passwordTextController.text)
                    //       .then((value) {
                    //     print("Created New Account");
                signInSignUpButton(context, false, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchWindow()),
                  );
                }),

                // .onError((error, stackTrace) {
                      //   print("Error ${error.toString()}");
                      // });
                    // })
                  ],
                ),
              ))),
    );
  }
}
