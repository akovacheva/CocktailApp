import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cocktailapp/constraints.dart';
import 'package:cocktailapp/services/cocktail_manager.dart';
import 'package:http/http.dart';
import 'package:cocktailapp/services/ingredients.dart';
import 'package:cocktailapp/ui_windows/result_window.dart';
import 'package:cocktailapp/main.dart';
import 'package:cocktailapp/components/random_cocktail_widget.dart';

import 'map.dart';

class SearchWindow extends StatefulWidget {
  final bool showAppBarActions;

  SearchWindow({this.showAppBarActions = true});

  @override
  _SearchWindow createState() => _SearchWindow();

}

class _SearchWindow extends State<SearchWindow>{
  String cocktailName = "";
  TextEditingController cocktailNameController = TextEditingController();

  @override
  void dispose() {
    cocktailNameController.dispose(); // Dispose the controller when the widget is disposed
    super.dispose();
  }

  Future<void> _showCocktailNotFoundError(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Cocktail Not Found",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  "The cocktail '$cocktailName' doesn't exist. Please search for another cocktail.",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "OK",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final isLoggedIn = user != null; // Declare isLoggedIn here
    return Scaffold(
      appBar: CommonAppBar(
        showBackButton: false,
        showAppBarActions: widget.showAppBarActions,
        // Pass a flag to CommonAppBar to determine whether to show the login icon
        showLoginIcon: isLoggedIn,
      ),
      body: Container(
    width: MediaQuery.of(context).size.width ,
    height: MediaQuery.of(context).size.height,
    decoration: const BoxDecoration(
    image: DecorationImage(
    image: AssetImage("assets/images/bottles.png"),
    opacity: 0.6,
    fit: BoxFit.cover,
    )
    ),
    child:SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(20.0),
    child: Container( // Wrap the Column with a Container
    constraints: BoxConstraints(maxHeight: 580), // Set a maximum height constraint
    child: Column(
    children: [
    Expanded( // Use Expanded around the Container
    child: Container(
    color: Colors.transparent,
    child: RandomCocktailWidget(),
    ),
    ),
        const SizedBox(height: 50,),
        //input
       TextField(
         controller: cocktailNameController, // Use the TextEditingController
         // When a value is changed, here it will be stored
         onChanged: (value) {
           setState(() {
             cocktailName = value; // Update the cocktailName
           });
         },
         decoration: InputDecoration(
           prefixIcon: const Icon(
             Icons.search,
             color: Colors.black45,
           ),
           filled: true,
           fillColor: Colors.white54,
           hintText: "Search for a cocktail",
           enabledBorder: OutlineInputBorder(
             borderRadius: BorderRadius.circular(15),
             borderSide: const BorderSide(
               color: txtFieldBorderColor,
               width: 2, // Adjust the border width as needed
             ),
           ),
             focusedBorder:  OutlineInputBorder(
                 borderRadius: BorderRadius.circular(15),
                 borderSide: const BorderSide(color: focusedTxtFieldBorderColor,
                   width: 2,),
         ),
       ),
        //search
       ),
        const SizedBox(height: 20,),

        //Search button
        ElevatedButton(onPressed: () async {
          // if(cocktailName == null) return;
          if (cocktailName.isEmpty) return;

          cocktailName.toLowerCase().replaceAll(' ', '_');
          CocktailManager cm = CocktailManager();
          //call info from db
          var network = await get(Uri.parse(mainUrl + cocktailName));
          var json = jsonDecode(network.body);
          print(network.body);

          if (json['drinks'] == null || json['drinks'].isEmpty) {
            await _showCocktailNotFoundError(context);
            return;
          }

          cm.name = json['drinks'][0]['strDrink'];
          cm.alcoholic = json['drinks'][0]['strAlcoholic'];
          cm.glassType = json['drinks'][0]['strGlass'];
          cm.pictureUrl = json['drinks'][0]['strDrinkThumb'];
          cm.category = json['drinks'][0]['strCategory'];
          cm.instructions = json['drinks'][0]['strInstructions'];

          String strIngredientName, strIngredientMeasure;
          List<Ingredients> ingrdientList = [];

          for (int i = 1; i < 16; i++) {
            strIngredientName = 'strIngredient' + i.toString();
            strIngredientMeasure = 'strMeasure' + i.toString();

            String ingredientName = json['drinks'][0][strIngredientName] ?? '';
            String ingredientMeasure = json['drinks'][0][strIngredientMeasure] ?? '';

            ingrdientList.add(
              Ingredients(
                name: ingredientName,
                mesure: ingredientMeasure,
              ),
            );
          }

          ingrdientList.removeWhere((element) =>
          element.name == null && element.mesure == null);

          ingrdientList.forEach((element) {
            if (element.mesure == null) {
              element.mesure = ' ';
            }
          });

          cm.ingredients = ingrdientList;

          // Clear the text field value
          cocktailNameController.clear();

          // put the other window on top of it, so we dont close it
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return ResultWindow(
                  name: cm.name,
                  category: cm.category,
                  alcoholic: cm.alcoholic,
                  glassType: cm.glassType,
                  pictureUrl: cm.pictureUrl,
                  instructions: cm.instructions,
                  ingredients: cm.ingredients,
              );
            }),
          );
        },
          child: Text("Search"),
        style: ElevatedButton.styleFrom(
          backgroundColor:btnColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          minimumSize: btnMinSize,
        ),
        ),
        const SizedBox(height: 20,),

        ElevatedButton(onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Map()),
          );
        },
          style: ElevatedButton.styleFrom(
            backgroundColor:btnColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            minimumSize: btnMinSize,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.map),
              SizedBox(width: 8),
              Text("Find a bar!"),
            ],
          ),
        ),
      ],),
    ),
    ),
    ),
    ),
    );
  }
}


