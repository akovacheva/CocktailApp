import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constraints.dart';
import '../main.dart';
import '../models/cocktail_model.dart';
import 'add_your_own_recipe_window.dart';
import 'cocktail_detail_window.dart';

class MyCocktailsScreen extends StatelessWidget {
  final List<Cocktail> cocktails;

  const MyCocktailsScreen(this.cocktails, {Key? key}) : super(key: key);

  void _showUndoPopup(BuildContext context, CocktailProvider cocktailProvider,
      Cocktail removedCocktail) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cocktail Deleted'),
          content: Text('Are you sure you want to delete this item?'),
          actions: [
            TextButton(
              child: Text('No'),
              onPressed: () {
                cocktailProvider.undoRemoveCocktail();
                Navigator.of(context).pop(); // Close the popup
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the popup
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cocktailProvider = Provider.of<CocktailProvider>(context);
    final cocktails = cocktailProvider.cocktails;

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
                          borderRadius: BorderRadius.circular(30),
                        ),
                        minimumSize: btnMinSize,
                      ),
                      child: const Text(
                        'Add',
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
                  return Dismissible(
                    key: Key(cocktail.name),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    dismissThresholds: {
                      DismissDirection.endToStart: 0.5,
                    },
                    onDismissed: (direction) {
                      final removedCocktail =
                          cocktailProvider.removeCocktail(cocktail);
                      _showUndoPopup(
                          context, cocktailProvider, removedCocktail);
                    },
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CocktailDetail(cocktail),
                          ),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        elevation: 5,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          leading: cocktail.imageFile != null
                              ? Image.file(
                                  cocktail.imageFile!,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                )
                              : Icon(Icons.image),
                          title: Text(cocktail.name ?? ''),
                          subtitle: Text(cocktail.description ?? ''),
                          trailing: // Inside MyCocktailsScreen
                              IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddYourOwnRecipeScreen(
                                      editCocktail: cocktail),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
