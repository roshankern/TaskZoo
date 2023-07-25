import 'package:isar/isar.dart';

part 'animalpieces.g.dart'; // This line will generate the adapter

@Collection()
class AnimalPieces {
  @Index()
  Id id;

  String animalName;

  int pieces;

  AnimalPieces({
    required this.id,
    required this.animalName,
    required this.pieces,
  });
}
