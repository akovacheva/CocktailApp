import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cocktailapp/constraints.dart';
import 'package:cocktailapp/services/cocktail_manager.dart';
import 'package:http/http.dart';
import 'package:cocktailapp/services/ingredients.dart';
import 'package:cocktailapp/ui_windows/result_window.dart';
import 'package:cocktailapp/main.dart';
import 'package:cocktailapp/components/random_cocktail_widget.dart';


class SearchWindow extends StatefulWidget {
  @override
  _SearchWindow createState() => _SearchWindow();

}

class _SearchWindow extends State<SearchWindow>{
  String cocktailName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
    body: SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
      children: [
        Container(
          height: 300.0, // Adjust the height as needed
          color: Colors.transparent,
          child: RandomCocktailWidget(),
        ),
        const SizedBox(height: 50,),
        //input
       TextField(
         // When a value is changed, here it will be stored
         onChanged: (value){
           cocktailName = value;
         },
         decoration: InputDecoration(
           hintText: "Search for a cocktail",
           enabledBorder: OutlineInputBorder(
             borderRadius: BorderRadius.circular(15),
             borderSide: const BorderSide(
               color: txtFieldBorderColor, // Change to the desired color
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
        //random button
        ElevatedButton(onPressed: () {}, child: Text("Make your own cocktail"),
          style: ElevatedButton.styleFrom(
            backgroundColor:btnColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            minimumSize: btnMinSize,
          ),
        ),

      ],),
    ),
    ),
    );
  }
}


