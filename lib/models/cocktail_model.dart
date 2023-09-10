import 'dart:io';

class Cocktail {
  final String id;
  final File imageFile;
  late final String name;
  late final String description;

  Cocktail({
    required this.id,
    required this.imageFile,
    required this.name,
    required this.description,
  });
}