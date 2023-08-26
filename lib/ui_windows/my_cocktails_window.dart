import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constraints.dart';
import '../main.dart';
import '../models/cocktail_model.dart';
import 'add_your_own_recipe_window.dart';
import 'cocktail_detail_window.dart';

class MyCocktailsScreen extends StatelessWidget {
  final List<Cocktail> cocktails;

  const MyCocktailsScreen(this.cocktails, {super.key});

  @override
  Widget build(BuildContext context) {
    final cocktailProvider = Provider.of<CocktailProvider>(context);
    final cocktails = cocktailProvider.cocktails;

    return Scaffold(
      appBar: const CommonAppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bottles.png"),
            opacity: 0.6,
            fit: BoxFit.cover,
          ),
        ),
        child: cocktails.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'No saved cocktails.',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddYourOwnRecipeScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: btnColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  minimumSize: btnMinSize,
                ),
                child: const Text(
                  'Create your own cocktail',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        )
            : ListView.builder(
          itemCount: cocktails.length,
          itemBuilder: (context, index) {
            final cocktail = cocktails[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CocktailDetail(cocktail), // Navigate to detail screen
                  ),
                );
              },
              child: Card(
                margin: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 20),
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
              ),
            );
          },
        ),
      ),
    );
  }
}
