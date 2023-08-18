import 'package:cocktailapp/constraints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cocktailapp/services/cocktail_manager.dart';
import 'package:http/http.dart';
import 'package:cocktailapp/services/ingredients.dart';
import 'dart:convert';
import 'package:cocktailapp/constraints.dart';
import 'package:cocktailapp/main.dart';

class SearchWindow extends StatefulWidget {

  @override
  _SearchWindow createState() => _SearchWindow();

}

class _SearchWindow extends State<SearchWindow>{
  late String cocktailName;

  @override
  Widget build(BuildContext context) {
    return Scaffold( appBar: CommonAppBar(),
    body: SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
      children: [
        const SizedBox(height: 100,),
        // Picture in a Box
        Container(
          width: 130, // Adjust the width of the box
          height: 130, // Adjust the height of the box
          decoration: BoxDecoration(
            color: Colors.white, // Set the color of the box
            borderRadius: BorderRadius.circular(10), // Set border radius
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Add shadow
                offset: Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
          child: Image.asset(
            "assets/images/blue.png", // Replace with your image asset path
            fit: BoxFit.cover,
          ),
        ),
        // Text Box with Surrounding Border
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black, // Border color
              width: 1, // Border width
            ),
            borderRadius: BorderRadius.circular(15), // Border radius
          ),
          padding: EdgeInsets.all(10), // Padding inside the container
          child: const Column(
            children: [
              Text(
                "Cocktail Of The day",
                style: TextStyle(fontSize: 20), // Customize text style
              ),
              Text(
                // cocktailName ?? '', // Display the text -> when we add api
                "Blue lagoon",
                style: TextStyle(fontSize: 15), // Customize text style
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: null,
                child: Text("More"),
              ),
            ],
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

            ingrdientList.add(
              Ingredients(
                name: json['drinks'][0][strIngredientName],
                mesure: json['drinks'][0][strIngredientMeasure],
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

        }, child: Text("Search"),
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


