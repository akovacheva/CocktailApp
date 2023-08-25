import 'package:flutter/material.dart';
import '../main.dart';
import '../models/cocktail_model.dart';

class MyCocktailsScreen extends StatelessWidget {
  final List<Cocktail> cocktails; //data structure to store cocktails

  MyCocktailsScreen(this.cocktails);

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
        child: ListView.builder(
          itemCount: cocktails.length,
          itemBuilder: (context, index) {
            final cocktail = cocktails[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              elevation: 5,
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                leading: Image.file(
                  cocktail.imageFile,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                title: Text(cocktail.name),
                subtitle: Text(cocktail.description),
              ),
            );
          },
        ),
      ),
    );
  }
}
