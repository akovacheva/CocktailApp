import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cocktailapp/constraints.dart';

class RandomCocktailWidget extends StatefulWidget {
  @override
  _RandomCocktailWidgetState createState() => _RandomCocktailWidgetState();
}

class _RandomCocktailWidgetState extends State<RandomCocktailWidget> {
  String cocktailName = "Blue lagoon"; // Default cocktail name
  String pictureUrl = "https://www.thecocktaildb.com/images/media/drink/5wm4zo1582579154.jpg"; // Default picture URL

  Future<Map<String, dynamic>> fetchRandomCocktail() async {
    var response = await http.get(
        Uri.parse("https://www.thecocktaildb.com/api/json/v1/1/random.php"));
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        children: [
          Image.network(
            pictureUrl,
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  "Cocktail Of The day",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20,),
                ),
                SizedBox(height: 5),
                Text(
                  cocktailName,
                  style: TextStyle(fontSize: 15,
                    fontWeight: FontWeight.bold,),
                  softWrap: false,
                  overflow: TextOverflow.fade,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    var jsonData = await fetchRandomCocktail();
                    var randomCocktail = jsonData['drinks'][0];

                    setState(() {
                      cocktailName = randomCocktail['strDrink'];
                      pictureUrl = randomCocktail['strDrinkThumb'];
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:btnColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text("Random"),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
