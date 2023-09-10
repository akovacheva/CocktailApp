import 'package:cocktailapp/ui_windows/add_your_own_recipe_window.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:cocktailapp/constraints.dart';
import 'package:cocktailapp/ui_windows/signIn_window.dart';
import 'package:cocktailapp/ui_windows/profile_window.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

import 'models/cocktail_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FlutterConfig.loadEnvVariables();
  await Permission.location.request();
  runApp(
    ChangeNotifierProvider(
      create: (context) => CocktailProvider(),
      child: const MyCocktailApp(),
    ),
  );
}

class MyCocktailApp extends StatelessWidget {
  const MyCocktailApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: appBarColor,
          iconTheme: IconThemeData(color: iconsColor),
        ),
      ),
      home: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/alcohol-bar-beer-beverage.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SignInWindow(),
        ],
      ),
    );
  }
}

class CocktailProvider with ChangeNotifier {
  List<Cocktail> _cocktails = [];
  int _lastRemovedIndex = -1;
  late Cocktail _lastRemovedCocktail;

  List<Cocktail> get cocktails => _cocktails;

  void addCocktail(Cocktail cocktail) {
    _cocktails.add(cocktail);
    notifyListeners();
  }

  Cocktail removeCocktail(Cocktail cocktail) {
    _lastRemovedIndex = _cocktails.indexOf(cocktail);
    _lastRemovedCocktail = cocktail; // Store the removed cocktail
    _cocktails.remove(cocktail);
    notifyListeners();
    return cocktail; // Return the removed cocktail
  }

  void undoRemoveCocktail() {
    if (_lastRemovedIndex != -1) {
      _cocktails.insert(_lastRemovedIndex, _lastRemovedCocktail);
      _lastRemovedIndex = -1;
      _lastRemovedCocktail = Cocktail(
        imageFile: File('path_to_placeholder_image_asset'),
        name: '',
        description: '', id: '',
      ); // Reset the stored cocktail
      notifyListeners();
    }
  }

  void editCocktail(Cocktail oldCocktail, Cocktail editedCocktail) {
    final index = _cocktails.indexWhere((cocktail) => cocktail.id == oldCocktail.id);
    if (index != -1) {
      _cocktails[index] = editedCocktail;
      notifyListeners();
    }
  }
}

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;
  final bool showAppBarActions;
  final bool showLoginIcon; // New flag for showing the login icon
  final String? username;

  CommonAppBar({
    Key? key,
    this.username,
    this.showBackButton = true,
    this.showAppBarActions = true,
    this.showLoginIcon = true, // Initialize it with true
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final isLoggedIn = user != null;

    return AppBar(
      automaticallyImplyLeading: showBackButton,
      backgroundColor: appBarColor,
      title: Image.asset(
        "assets/images/white-no-background.png",
        width: 100,
        height: 100,
      ),
      centerTitle: true,
      actions: [
        if (showAppBarActions && isLoggedIn)
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
        if (showLoginIcon)
          IconButton(
            icon: isLoggedIn
                ? const Icon(Icons.logout) // Show logout icon when logged in
                : const Icon(Icons.login_outlined), // Show login icon when not logged in
            onPressed: () {
              if (isLoggedIn) {
                // Handle logout logic here
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SignInWindow()),
                  );
                });
              } else {
                // Handle login logic here
                // You can navigate to the login screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignInWindow()),
                );
              }
            },
          ),

        // if (showAppBarActions && isLoggedIn) // Show the login icon based on the flag
        //   IconButton(
        //     icon: const Icon(Icons.login_outlined),
        //     onPressed: () {
        //       FirebaseAuth.instance.signOut().then((value) {
        //         Navigator.pushReplacement(
        //           context,
        //           MaterialPageRoute(builder: (context) => SignInWindow()),
        //         );
        //       });
        //     },
        //   ),
        // if (showLoginIcon) // Show the login icon based on the flag
        //   IconButton(
        //     icon: const Icon(Icons.login_outlined),
        //     onPressed: () {
        //       FirebaseAuth.instance.signOut().then((value) {
        //         Navigator.pushReplacement(
        //           context,
        //           MaterialPageRoute(builder: (context) => SignInWindow()),
        //         );
        //       });
        //     },
        //   ),
      ],
    );
  }
}