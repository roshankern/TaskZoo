class Biomes {
  List<Biome> biomes;

  Biomes({required this.biomes});

  factory Biomes.fromJson(Map<String, dynamic> json) {
    return Biomes(
      biomes: (json['biomes'] as List).map((i) => Biome.fromJson(i)).toList(),
    );
  }

  void printBiomes() {
    biomes.forEach((biome) {
      print('Biome name: ${biome.name}');
      print('Primary Color: ${biome.primaryColor}');
      print('Secondary Color: ${biome.secondaryColor}');
      print('Icon Name: ${biome.icon.name}');
      print('Icon SVG Path: ${biome.icon.svgPath}');
      print('Animals:');
      biome.animals.forEach((animal) {
        print('  Animal Name: ${animal.name}');
        print('  Animal SVG Path: ${animal.svgPath}');
      });
      print('--------------------------------');
    });
  }
}

class Biome {
  String name;
  String primaryColor;
  String secondaryColor;
  BiomeIcon icon;
  List<Animal> animals;

  Biome({required this.name, required this.primaryColor, required this.secondaryColor, required this.icon, required this.animals});

  factory Biome.fromJson(Map<String, dynamic> json) {
    return Biome(
      name: json['name'],
      primaryColor: json['primary_color'],
      secondaryColor: json['secondary_color'],
      icon: BiomeIcon.fromJson(json['icon']),
      animals: (json['animals'] as List).map((i) => Animal.fromJson(i)).toList(),
    );
  }
}

class BiomeIcon {
  String name;
  String svgPath;

  BiomeIcon({required this.name, required this.svgPath});

  factory BiomeIcon.fromJson(Map<String, dynamic> json) {
    return BiomeIcon(
      name: json['name'],
      svgPath: json['svg_path'],
    );
  }
}

class Animal {
  String name;
  String svgPath;

  Animal({required this.name, required this.svgPath});

  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
      name: json['name'],
      svgPath: json['svg_path'],
    );
  }
}
