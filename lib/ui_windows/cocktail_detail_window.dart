import 'package:cocktailapp/constraints.dart';
import 'package:cocktailapp/main.dart';
import 'package:flutter/material.dart';
import '../models/cocktail_model.dart';

class CocktailDetail extends StatelessWidget {
  final Cocktail cocktail;

  const CocktailDetail(this.cocktail, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/bottles.png"),
          opacity: 0.6,
          fit: BoxFit.cover,
        )),
        child: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Card(
            elevation: 10,
            color: btnColor, // Set the background color to pink
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20.0),
                  ),
                  child: Image.file(
                    cocktail.imageFile,
                    width: MediaQuery.of(context).size.width,
                    height: 260,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(46.0),
                  child: Text(
                    cocktail.name,
                    style: TextStyle(
                      fontSize: txtHeader.fontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      decoration:
                          TextDecoration.underline,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26.0),
                  child: Text(
                    cocktail.description,
                    style: TextStyle(
                      fontSize: tableTextStyle.fontSize,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
