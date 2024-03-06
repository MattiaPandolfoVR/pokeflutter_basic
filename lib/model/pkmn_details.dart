import 'dart:convert';

PokemonDetails pokemonDetailsFromJson(String str) =>
    PokemonDetails.fromJson(json.decode(str));

String pokemonDetailsToJson(PokemonDetails data) => json.encode(data.toJson());

class PokemonDetails {
  int id;
  String name;
  Sprites sprites;
  List<Stat> stats;
  List<Type> types;

  List<Stat> get getStats => stats;

  PokemonDetails({
    required this.id,
    required this.name,
    required this.sprites,
    required this.stats,
    required this.types,
  });

  factory PokemonDetails.fromJson(Map<String, dynamic> json) => PokemonDetails(
        id: json["id"],
        name: json["name"],
        sprites: Sprites.fromJson(json["sprites"]),
        stats: List<Stat>.from(json["stats"].map((x) => Stat.fromJson(x))),
        types: List<Type>.from(json["types"].map((x) => Type.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "sprites": sprites.toJson(),
        "stats": List<dynamic>.from(stats.map((x) => x.toJson())),
        "types": List<dynamic>.from(types.map((x) => x.toJson())),
      };
}

class Utils {
  String name;
  String url;

  Utils({
    required this.name,
    required this.url,
  });

  factory Utils.fromJson(Map<String, dynamic> json) => Utils(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

class Other {
  OfficialArtwork officialArtwork;

  Other({
    required this.officialArtwork,
  });

  factory Other.fromJson(Map<String, dynamic> json) => Other(
        officialArtwork: OfficialArtwork.fromJson(json["official-artwork"]),
      );

  Map<String, dynamic> toJson() => {
        "official-artwork": officialArtwork.toJson(),
      };
}

class Sprites {
  Other? other;

  Sprites({
    this.other,
  });

  factory Sprites.fromJson(Map<String, dynamic> json) => Sprites(
        other: json["other"] == null ? null : Other.fromJson(json["other"]),
      );

  Map<String, dynamic> toJson() => {
        "other": other?.toJson(),
      };
}

class OfficialArtwork {
  String frontDefault;
  String frontShiny;

  OfficialArtwork({
    required this.frontDefault,
    required this.frontShiny,
  });

  factory OfficialArtwork.fromJson(Map<String, dynamic> json) =>
      OfficialArtwork(
        frontDefault: json["front_default"],
        frontShiny: json["front_shiny"],
      );

  Map<String, dynamic> toJson() => {
        "front_default": frontDefault,
        "front_shiny": frontShiny,
      };
}

class Stat {
  int baseStat;
  int effort;
  Utils stat;

  Stat({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
        baseStat: json["base_stat"],
        effort: json["effort"],
        stat: Utils.fromJson(json["stat"]),
      );

  Map<String, dynamic> toJson() => {
        "base_stat": baseStat,
        "effort": effort,
        "stat": stat.toJson(),
      };
}

class Type {
  int slot;
  Utils type;

  Type({
    required this.slot,
    required this.type,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        slot: json["slot"],
        type: Utils.fromJson(json["type"]),
      );

  Map<String, dynamic> toJson() => {
        "slot": slot,
        "type": type.toJson(),
      };
}
