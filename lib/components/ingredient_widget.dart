import 'package:flutter/material.dart';
import 'package:cocktailapp/constraints.dart';
import 'package:cocktailapp/services/ingredients.dart';

class IngredientWidget extends StatelessWidget {
  IngredientWidget({required this.ingredientList});
  final List<Ingredients> ingredientList;

  Widget createTable() {
    List<TableRow> rows = [];

    for (int i = 0; i < ingredientList.length; i++) {
      rows.add(
        TableRow(
          children: [
            Center(
              child: Text(ingredientList[i].name),
            ),
            Center(
              child: Text(ingredientList[i].mesure),
            ),
          ],
        ),
      );
    }

    return Table(children: rows);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Ingredients",
          style: tableTextStyle,
        ),
        SizedBox(
          height: 30,
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: createTable(),
          ),
        ),
      ],
    );
  }
}