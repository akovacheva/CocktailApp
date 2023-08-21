import 'package:flutter/material.dart';
import 'package:cocktailapp/components/authentication_widget.dart';
import 'package:cocktailapp/ui_windows/signUp_window.dart';

class SignInWindow extends StatefulWidget {
  const SignInWindow({super.key});

  @override
  State<SignInWindow> createState() => _SignInWindowState();
}

class _SignInWindowState extends State<SignInWindow> {

  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();


  @override
  Widget build(BuildContext context) {
      return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width ,
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
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget> [
                logoWidget("assets/images/logo.png"),
                SizedBox(
                  height: 30,
                ),
                inputField("Enter username", Icons.person_outline, false, _emailTextController),
                SizedBox(
                  height: 20,
                ),
                inputField("Enter your password", Icons.lock_outline, true, _passwordTextController),
                SizedBox(
                  height: 20,
                ),
                signInSignUpButton(context, true, (){}),
                signUpOption(),
              ],
            ),
          ),
        )
    ),
    );
  }

  Row signUpOption(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyle(
            color: Colors.white70),),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpWindow()));
          },
          child: const Text(
            "Register",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );

  }

}


