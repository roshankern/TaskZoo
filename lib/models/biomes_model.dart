class Biomes {
  Map<String, Biome> biomes;

  Biomes({required this.biomes});

  factory Biomes.fromJson(Map<String, dynamic> json) {
    return Biomes(
      biomes: (json['biomes'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, Biome.fromJson(value)),
      ),
    );
  }
}

class Biome {
  String primaryColor;
  String secondaryColor;
  Icon icon;
  List<Animal> animals;

  Biome({required this.primaryColor, required this.secondaryColor, required this.icon, required this.animals});

  factory Biome.fromJson(Map<String, dynamic> json) {
    return Biome(
      primaryColor: json['primary_color'],
      secondaryColor: json['secondary_color'],
      icon: Icon.fromJson(json['icon']),
      animals: (json['animals'] as List).map((i) => Animal.fromJson(i)).toList(),
    );
  }
}

class Icon {
  String name;
  String svgPath;

  Icon({required this.name, required this.svgPath});

  factory Icon.fromJson(Map<String, dynamic> json) {
    return Icon(
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
      svgPath: json['svgPath'],
    );
  }
}
