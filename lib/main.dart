import 'package:cocktailapp/constraints.dart';
import 'package:cocktailapp/ui_windows/search_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  //portrait mode
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyCocktailApp()));
}

class MyCocktailApp extends StatelessWidget {
  const MyCocktailApp({super.key});


  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: appBarColor,
          iconTheme: IconThemeData(color: iconsColor), // Customize icon color
        ),
      //Promena na pozadina
        // scaffoldBackgroundColor: const Color(0xFF1f2129)
      ),
      home: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/alcohol-bar-beer-beverage.jpg"), // Replace with your image asset path
                fit: BoxFit.cover, // Adjust how the image should fit the container
              ),
            ),
          ),
          // Main Content
          SearchWindow(),
        ],
      ),
    );
  }
}


class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
    backgroundColor: appBarColor, // Set transparent background
    title: const Text('DRINKY'),
    actions: [
    IconButton(
    icon: const Icon(Icons.person),
    onPressed: () {
    // Implement your profile functionality here
    },
    ),
    ],
    );
  }
}
