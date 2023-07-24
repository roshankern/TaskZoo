import 'package:isar/isar.dart';

part 'animalpieces.g.dart'; // This line will generate the adapter

@Collection()
class AnimalPieces {
  Id id = Isar.autoIncrement;
  @Index()
  String animalName;

  @Index()
  int pieces;

  AnimalPieces({
    Id id = Isar.autoIncrement,
    required this.animalName,
    required this.pieces,
  });
}
