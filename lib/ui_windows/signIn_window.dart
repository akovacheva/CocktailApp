import 'package:flutter/material.dart';
import 'package:cocktailapp/components/authentication_widget.dart';

class SignInWindow extends StatefulWidget {
  const SignInWindow({super.key});

  @override
  State<SignInWindow> createState() => _SignInWindowState();
}

class _SignInWindowState extends State<SignInWindow> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width ,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/alcohol-bar-beer-beverage.jpg"),
            fit: BoxFit.cover,
          )
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget> [
                logoWidget("assets/images/logo.png")
              ],
            ),
          ),
        )
    ),
    );
  }
}


