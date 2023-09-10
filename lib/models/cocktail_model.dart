import 'dart:io';

class Cocktail {
  final File imageFile;
  late final String name;
  late final String description;

  Cocktail({
    required this.imageFile,
    required this.name,
    required this.description,
  });

  Cocktail copyWith({
    File? imageFile,
    String? name,
    String? description,
  }) {
    return Cocktail(
      imageFile: imageFile ?? this.imageFile,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }
}
