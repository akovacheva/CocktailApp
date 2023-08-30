import 'dart:convert';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(showBackButton: false, showAppBarActions: widget.showAppBarActions),
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
         // When a value is changed, here it will be stored
         onChanged: (value){
           cocktailName = value;
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
          if(cocktailName == null) return;

          cocktailName.toLowerCase().replaceAll(' ', '_');
          CocktailManager cm = CocktailManager();
          //call info from db
          var network = await get(Uri.parse(mainUrl + cocktailName));
          var json = jsonDecode(network.body);
          print(network.body);

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
                  ingredients: cm.ingredients);
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


