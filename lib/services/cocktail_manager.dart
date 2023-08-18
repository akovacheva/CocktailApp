import 'package:cocktailapp/services/ingredients.dart';
// class CocktailManager {
//   String name;
//   String category;
//   String alcoholic;
//   String glassType;
//   String pictureUrl;
//   String instructions;
//   List<Ingredients> ingredients;
//
//   CocktailManager(
//       {required this.name,
//         required this.category,
//         required this.alcoholic,
//         required this.glassType,
//         required this.pictureUrl,
//         required this.instructions,
//         required this.ingredients});
//
//
// }

class CocktailManager {
  String name;
  String category;
  String alcoholic;
  String glassType;
  String pictureUrl;
  String instructions;
  List<Ingredients> ingredients;

  CocktailManager({
    this.name = "",
    this.category = "",
    this.alcoholic = "",
    this.glassType = "",
    this.pictureUrl = "",
    this.instructions = "",
    this.ingredients = const [],
  });
}