import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../constraints.dart';
import '../main.dart';
import '../models/cocktail_model.dart';
import 'package:permission_handler/permission_handler.dart';

class AddYourOwnRecipeScreen extends StatefulWidget {
  final Cocktail? editCocktail; // Accept editCocktail as a parameter

  AddYourOwnRecipeScreen({this.editCocktail}); // Constructor

  @override
  _AddYourOwnRecipeScreenState createState() => _AddYourOwnRecipeScreenState();
}

class _AddYourOwnRecipeScreenState extends State<AddYourOwnRecipeScreen> {
  File? imageFile;
  TextEditingController _cocktailNameController = TextEditingController();
  TextEditingController _cocktailDescriptionController =
      TextEditingController();
  bool isFirstCameraClick = true;

  @override
  void initState() {
    super.initState();

    // Pre-fill form fields if editing
    if (widget.editCocktail != null) {
      final editedCocktail = widget.editCocktail!;
      _cocktailNameController.text = editedCocktail.name ?? '';
      _cocktailDescriptionController.text = editedCocktail.description ?? '';

      if (editedCocktail.imageFile != null) {
        // Set the imageFile if it's available in the editCocktail
        setState(() {
          imageFile = editedCocktail.imageFile;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bottles.png"),
            opacity: 0.6,
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 50.0, 12.0, 12.0),
            child: Column(
              children: [
                if (imageFile != null)
                  Container(
                    width: 240,
                    height: 180,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      image: DecorationImage(
                        image: FileImage(imageFile!),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(width: 3, color: btnColor),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  )
                else
                  Container(
                    width: 240,
                    height: 180,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      border: Border.all(width: 3, color: btnColor),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: const Text(
                      'No image',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => captureImage(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: btnColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          minimumSize: btnMinSize,
                        ),
                        child: const Text(
                          'Capture Image',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => getImage(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: btnColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          minimumSize: btnMinSize,
                        ),
                        child: const Text(
                          'Select Image',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _cocktailNameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.local_drink,
                      color: Colors.black45,
                    ),
                    filled: true,
                    fillColor: Colors.white54,
                    hintText: 'Cocktail Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _cocktailDescriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.description,
                      color: Colors.black45,
                    ),
                    filled: true,
                    fillColor: Colors.white54,
                    hintText: 'Cocktail Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveCocktail,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: btnColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minimumSize: btnMinSize,
                  ),
                  child: const Text(
                    'Save Cocktail',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> captureImage() async {
    var status = await Permission.camera.request();

    if (status.isGranted) {
      // Capture an image from the camera
      XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxHeight: 1800,
        maxWidth: 1000,
      );

      if (pickedFile != null) {
        setState(() {
          imageFile = File(pickedFile.path);
        });
      }
    } else if (status.isDenied || status.isPermanentlyDenied) {
      // Permission denied. Show a dialog to request permission.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Camera Permission'),
            content: Text(
                'CocktailApp needs access to your camera to capture images.'),
            actions: <Widget>[
              TextButton(
                child: Text('Always'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  var result = await Permission.camera.request();
                  if (result.isGranted) {
                    captureImage();
                  } else {
                    // Handle the case when the user denies permission even after selecting "Always."
                  }
                },
              ),
              TextButton(
                child: Text('Only Once'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  var result = await Permission.camera.request();
                  if (result.isGranted) {
                    captureImage();
                  } else {
                    // Handle the case when the user denies permission for "Only Once."
                  }
                },
              ),
              TextButton(
                child: Text('Never'),
                onPressed: () {
                  Navigator.of(context).pop();
                  // Handle the case when the user selects "Never."
                },
              ),
            ],
          );
        },
      );
    }
  }

  getImage(context) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 1800,
      maxWidth: 1000,
    );
  }

  void _saveCocktail() {
    if (imageFile != null &&
        _cocktailNameController.text.isNotEmpty &&
        _cocktailDescriptionController.text.isNotEmpty) {
      final editedCocktail = Cocktail(
        id: widget.editCocktail?.id ?? UniqueKey().toString(),
        // Generate a new ID if it's a new cocktail
        imageFile: imageFile!,
        name: _cocktailNameController.text,
        description: _cocktailDescriptionController.text,
      );

      final cocktailProvider =
          Provider.of<CocktailProvider>(context, listen: false);

      if (widget.editCocktail == null) {
        // Adding a new cocktail
        cocktailProvider.addCocktail(editedCocktail);
      } else {
        // Editing an existing cocktail
        cocktailProvider.editCocktail(widget.editCocktail!, editedCocktail);
      }

      Navigator.pop(context); // Close the screen
    } else {
      // Show an alert dialog if any field is empty
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please fill in all fields.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _cocktailNameController.dispose();
    _cocktailDescriptionController.dispose();
    super.dispose();
  }
}
