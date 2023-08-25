import 'package:cocktailapp/constraints.dart';
import 'package:cocktailapp/ui_windows/search_window.dart';
import 'package:cocktailapp/ui_windows/signIn_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cocktailapp/ui_windows/profile_window.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async{
  //portrait mode
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
          SignInWindow(),
        ],
      ),
    );
  }
}


class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;
  const CommonAppBar({Key? key, this.showBackButton = true})
      : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(automaticallyImplyLeading: showBackButton,
    backgroundColor: appBarColor, // Set transparent background
        title: Text("Drinky",
          style: TextStyle(
            fontStyle: FontStyle.italic, // Change to your desired font style
            color: titleColor, // Change to your desired text color
            fontSize: 20, // Change to your desired font size
            fontWeight: FontWeight.bold, // Optionally, set font weight
          ),),
        centerTitle: true,
      // leading:
      // Image.asset(
      //     "assets/images/logob.png",
      // ),
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
