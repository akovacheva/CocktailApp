import 'package:flutter/material.dart';

import '../constraints.dart';
import '../main.dart';
import '../models/cocktail_model.dart';
import 'add_your_own_recipe_window.dart';
import 'my_cocktails_window.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Cocktail> savedCocktails = []; // List to store saved cocktails

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      body:Container(
        width: MediaQuery.of(context).size.width ,
    height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage("assets/images/bottles.png"),
    opacity: 0.6,
    fit: BoxFit.cover,
    )
    ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 50),
              ElevatedButtonWithIcon(
                onPressed: () async {
                  final newCocktail = await Navigator.push<Cocktail>(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddYourOwnRecipeScreen()),
                  );
                  if (newCocktail != null) {
                    setState(() {
                      savedCocktails.add(newCocktail);
                    });
                  }
                },
                buttonText: 'Add a Recipe',
              ),
              SizedBox(height: 60),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MyCocktailsScreen(savedCocktails)),
                  );
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
              // Image.asset('assets/images/my_cocktails_image.png'),
            ],
          ),
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
        // Positioned(
        //   right: 10,
        //   bottom: 10,
        //   child: FloatingActionButton(
        //     onPressed: onPressed,
        //     child: Icon(Icons.add_circle_outline),
        //     backgroundColor: iconsColor,
        //     mini: true, // Make the FloatingActionButton smaller
        //   ),
        // ),
      ],
    );
  }
}
