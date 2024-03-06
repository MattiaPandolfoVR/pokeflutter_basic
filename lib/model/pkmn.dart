// class Pkmn {
//   Pkmn({
//     this.id,
//     this.name,
//     this.url,
//     this.imageUrl,
//   });

//   int? id;
//   String? name;
//   String? url;
//   String? imageUrl;

//   Pkmn.fromJson(dynamic json) {
//     url = json['url'];
//     id = int.parse(url!.split('/')[6]);
//     name = json['name'];
//     imageUrl =
//         "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png";
//   }

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     map['name'] = name;
//     map['url'] = url;
//     map['imageUrl'] = imageUrl;
//     return map;
//   }
// }

class PokemonResults {
  PokemonResults({
    required this.name,
    required this.url,
    //required this.sprites,
  });

  String name;
  String url;
  //Sprites sprites;

  String get getName => name;

  factory PokemonResults.fromJson(Map<String, dynamic> json) {
    return PokemonResults(
      name: json['name'],
      url: json['url'],
      //sprites: Sprites.fromJson(json["sprites"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
        //"sprites": sprites.toJson(),
      };
}

// class Other {
//   OfficialArtwork officialArtwork;

//   Other({
//     required this.officialArtwork,
//   });

//   factory Other.fromJson(Map<String, dynamic> json) => Other(
//         officialArtwork: OfficialArtwork.fromJson(json["official-artwork"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "official-artwork": officialArtwork.toJson(),
//       };
// }

// class Sprites {
//   Other? other;

//   Sprites({
//     this.other,
//   });

//   factory Sprites.fromJson(Map<String, dynamic> json) => Sprites(
//         other: json["other"] == null ? null : Other.fromJson(json["other"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "other": other?.toJson(),
//       };
// }

// class OfficialArtwork {
//   String frontDefault;
//   String frontShiny;

//   OfficialArtwork({
//     required this.frontDefault,
//     required this.frontShiny,
//   });

//   factory OfficialArtwork.fromJson(Map<String, dynamic> json) =>
//       OfficialArtwork(
//         frontDefault: json["front_default"],
//         frontShiny: json["front_shiny"],
//       );

//   Map<String, dynamic> toJson() => {
//         "front_default": frontDefault,
//         "front_shiny": frontShiny,
//       };
// }
