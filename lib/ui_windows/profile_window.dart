import 'package:flutter/material.dart';
import '../constraints.dart';
import '../main.dart';
import 'add_your_own_recipe_window.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 50),
              ElevatedButtonWithIcon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddYourOwnRecipeScreen()),
                  );
                },
                buttonText: 'Add your own Recipe',
              ),
              SizedBox(height: 60),
              ElevatedButton(
                onPressed: () {
                  // Implement functionality for the "My Cocktails" button
                },
                child: Text('My Cocktails'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: btnColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: Size(double.infinity, 80),
                  elevation: 15,
                ),
              ),
              SizedBox(height: 60),
              Image.asset('assets/images/my_cocktails_image.png'),
            ],
          ),
        ),
      ),
    );
  }
}

class ElevatedButtonWithIcon extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;

  ElevatedButtonWithIcon({required this.onPressed, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          child: ElevatedButton(
            onPressed: onPressed,
            child: Text(buttonText),
            style: ElevatedButton.styleFrom(
              backgroundColor: btnColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              minimumSize: Size(double.infinity, 80),
              elevation: 15,
            ),
          ),
        ),
        Positioned(
          right: 10,
          bottom: 10,
          child: FloatingActionButton(
            onPressed: onPressed,
            child: Icon(Icons.add),
            backgroundColor: iconsColor,
            mini: true, // Make the FloatingActionButton smaller
          ),
        ),
      ],
    );
  }
}
