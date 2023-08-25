import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:cocktailapp/constraints.dart';
import 'package:cocktailapp/ui_windows/signIn_window.dart';
import 'package:cocktailapp/ui_windows/profile_window.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'models/cocktail_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FlutterConfig.loadEnvVariables();

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

  List<Cocktail> get cocktails => _cocktails;

  void addCocktail(Cocktail cocktail) {
    _cocktails.add(cocktail);
    notifyListeners();
  }
}

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;
  final String? username;
  const CommonAppBar({Key? key, this.username, this.showBackButton = true})
        : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(automaticallyImplyLeading: showBackButton,
    backgroundColor: appBarColor, // Set transparent background
        title:
        Image.asset(
          //need to choose
          "assets/images/white-no-background.png",
          // "assets/images/black.png",
          width: 100,
          height: 100,
        ),
        // Text(
        //   username ?? "Drinky",
        //   style: TextStyle(
        //     fontStyle: FontStyle.italic,
        //     color: titleColor,
        //     fontSize: 20,
        //     fontWeight: FontWeight.bold,
        centerTitle: true,
    actions: [
    IconButton(
    icon: const Icon(Icons.person),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen()),
      );
      },
    ),
      IconButton(
        icon: const Icon(Icons.logout_outlined),
        onPressed: () {
          FirebaseAuth.instance.signOut().then((value) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignInWindow()),
            );
          });
        },
      ),
    ],
    );
  }
}
