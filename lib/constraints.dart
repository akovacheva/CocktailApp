import 'package:flutter/material.dart';

const mainUrl = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=";
const randomUrl = "https://www.thecocktaildb.com/api/json/v1/1/random.php";
const appBarColor = Colors.transparent;
const iconsColor = Colors.black;
const txtFieldBorderColor = Colors.grey;
const focusedTxtFieldBorderColor = Colors.lightBlue;
const btnColor = Colors.blueGrey;
const containerColor = Colors.black12;

const borderSide = BorderSide(
  color: focusedTxtFieldBorderColor,
  width: 5
);

const txtHeader = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w700
);

const tableTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w500,
);

const btnMinSize =  Size(100, 55);

const boxDecorationStyle = BoxDecoration(
  color: containerColor,
  borderRadius: BorderRadius.all(Radius.circular(30))
);
