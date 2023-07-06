class Biomes {
  List<Biome> biomes;

  Biomes({required this.biomes});

  factory Biomes.fromJson(Map<String, dynamic> json) {
    final List<dynamic> biomesJson = json['biomes'] as List<dynamic>;
    final List<Biome> biomes = biomesJson.map((item) => Biome.fromJson(item)).toList();

    return Biomes(biomes: biomes);
  }
}

class Biome {
  String name;
  String primaryColor;
  String secondaryColor;
  BiomeIcon icon;

  Biome({
    required this.name,
    required this.primaryColor,
    required this.secondaryColor,
    required this.icon,
  });

  factory Biome.fromJson(Map<String, dynamic> json) {
    return Biome(
      name: json['name'] as String,
      primaryColor: json['primaryColor'] as String,
      secondaryColor: json['secondaryColor'] as String,
      icon: BiomeIcon.fromJson(json['icon']),
    );
  }
}

class BiomeIcon {
  String name;
  String svgPath;

  BiomeIcon({
    required this.name,
    required this.svgPath,
  });

  factory BiomeIcon.fromJson(Map<String, dynamic> json) {
    return BiomeIcon(
      name: json['name'] as String,
      svgPath: json['svgPath'] as String,
    );
  }
}
