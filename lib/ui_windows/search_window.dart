import 'package:cocktailapp/constraints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class SearchWindow extends StatefulWidget {

  @override
  _SearchWindow createState() => _SearchWindow();

}

//TEST

class _SearchWindow extends State<SearchWindow>{
  late String cocktailName;

  @override
  Widget build(BuildContext context) {
    return Scaffold( appBar: CommonAppBar(),
    body: SafeArea(
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
        ElevatedButton(onPressed: () {}, child: Text("Search"),
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


