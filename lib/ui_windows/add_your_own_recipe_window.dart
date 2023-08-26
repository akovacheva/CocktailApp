import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../constraints.dart';
import '../main.dart';
import '../models/cocktail_model.dart';

class AddYourOwnRecipeScreen extends StatefulWidget {
  @override
  _AddYourOwnRecipeScreenState createState() => _AddYourOwnRecipeScreenState();
}

class _AddYourOwnRecipeScreenState extends State<AddYourOwnRecipeScreen> {
  File? imageFile;
  TextEditingController _cocktailNameController = TextEditingController();
  TextEditingController _cocktailDescriptionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      body:
    Container(
    width: MediaQuery.of(context).size.width ,
    height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage("assets/images/bottles.png"),
    opacity: 0.6,
    fit: BoxFit.cover,
    )
    ),
     child:  SingleChildScrollView(
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
                      onPressed: () => getImage(source: ImageSource.camera),
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
                      onPressed: () => getImage(source: ImageSource.gallery),
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
                  prefixIcon: Icon(
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
                textInputAction: TextInputAction.done, // Add this line
                // onEditingComplete: _saveCocktail,
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

  void getImage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(
      source: source,
      maxWidth: 240,
      maxHeight: 180,
      imageQuality: 70,
    );

    if (file?.path != null) {
      setState(() {
        imageFile = File(file!.path);
      });
    }
  }

  void _saveCocktail() {
    if (imageFile != null &&
        _cocktailNameController.text.isNotEmpty &&
        _cocktailDescriptionController.text.isNotEmpty) {
      final newCocktail = Cocktail(
        imageFile: imageFile!,
        name: _cocktailNameController.text,
        description: _cocktailDescriptionController.text,
      );

      final cocktailProvider = Provider.of<CocktailProvider>(context, listen: false);
      cocktailProvider.addCocktail(newCocktail);

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
