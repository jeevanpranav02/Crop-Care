import 'dart:io';

class PlantImageDetailsCard {
  final int index;
  final String name;
  final String disease;
  final File image;

  PlantImageDetailsCard({
    required this.index,
    required this.name,
    required this.disease,
    required this.image,
  });
}
