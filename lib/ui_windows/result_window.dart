import 'package:flutter/material.dart';
import 'package:cocktailapp/constraints.dart';
import 'package:cocktailapp/main.dart';
import 'package:cocktailapp/services/ingredients.dart';
import 'package:cocktailapp/components/ingredient_widget.dart';
import 'package:cocktailapp/components/instruction_widget.dart';


class ResultWindow extends StatelessWidget {

  final String name;
  final String category;
  final String alcoholic;
  final String glassType;
  final String pictureUrl;
  final String instructions;
  final List<Ingredients> ingredients;

  ResultWindow({
    required this.name,
    required this.category,
    required this.alcoholic,
    required this.glassType,
    required this.pictureUrl,
    required this.instructions,
    required this.ingredients,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      body: SafeArea(
        child: Column(
          //za so ekranot
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              //Cocktail name
             child: Text(name, style: txtHeader,),
            ),
              //Cocktail details
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 40,
                decoration: BoxDecoration(
                  color: containerColor
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(category),
                    Text("‣"),
                    Text(alcoholic),
                    Text("‣"),
                    Text(glassType),
                  ],
                ),
              ),
              //Cocktail image
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    image: NetworkImage(pictureUrl)
                  ),
                ),
              ),
              //Ingredients
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 200,
                decoration: boxDecorationStyle,
                child: IngredientWidget(
                  ingredientList: ingredients,
                ),
              ),
              //Instructions
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 200,
                decoration: boxDecorationStyle,
                child: InstructionWidget(
                    instructions: instructions,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
