class Biomes {
  List<Biome>? biomes;

  Biomes({this.biomes});

  Biomes.fromJson(Map<String, dynamic> json) {
    if (json['biomes'] != null) {
      biomes = [];
      print(json['biomes']);
      json['biomes'].forEach((Map<String, dynamic>v) {
        print(v);
        biomes!.add(new Biome.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.biomes != null) {
      data['biomes'] = this.biomes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Biome {
  String? name;
  String? primaryColor;
  String? secondaryColor;
  BiomeIcon? icon;
  List<Animal>? animals;

  Biome(
      {this.name,
      this.primaryColor,
      this.secondaryColor,
      this.icon,
      this.animals});

  Biome.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    primaryColor = json['primary_color'];
    secondaryColor = json['secondary_color'];
    icon = json['icon'] != null ? new BiomeIcon.fromJson(json['icon']) : null;
    if (json['animals'] != null) {
      animals = [];
      json['animals'].forEach((v) {
        animals!.add(new Animal.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['primary_color'] = this.primaryColor;
    data['secondary_color'] = this.secondaryColor;
    if (this.icon != null) {
      data['icon'] = this.icon!.toJson();
    }
    if (this.animals != null) {
      data['animals'] = this.animals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BiomeIcon {
  String? name;
  String? svgPath;

  BiomeIcon({this.name, this.svgPath});

  BiomeIcon.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    svgPath = json['svg_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['svg_path'] = this.svgPath;
    return data;
  }
}

class Animal {
  String? name;
  String? svgPath;

  Animal({this.name, this.svgPath});

  Animal.fromJson(Map<String, dynamic> json) {
    print(json['name']);
    name = json['name'];
    svgPath = json['svg_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['svg_path'] = this.svgPath;
    return data;
  }
}
