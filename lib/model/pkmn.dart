/* Questo funziona */

class PokemonResults {
  List<PokemonListResult> pokemonList;
  PokemonDetails? specificPokemonDetails;

  PokemonResults({required this.pokemonList, this.specificPokemonDetails});

  factory PokemonResults.fromJson(Map<String, dynamic> json) {
    var resultsList = json['results'] as List;
    List<PokemonListResult> pokemonListItems =
        resultsList.map((e) => PokemonListResult.fromJson(e)).toList();

    return PokemonResults(pokemonList: pokemonListItems);
  }

  void setSpecificPokemonDetails(PokemonDetails details) {
    specificPokemonDetails = details;
  }
}

class PokemonListResult {
  String name;
  String url;

  String get getName => name;

  PokemonListResult({required this.name, required this.url});

  factory PokemonListResult.fromJson(Map<String, dynamic> json) {
    return PokemonListResult(
      name: json['name'],
      url: json['url'],
    );
  }
}

class PokemonDetails {
  int id;
  String name;
  int order;
  String officialArtworkSprite;
  List<PokemonStat> stats;
  List<PokemonType> types;

  PokemonDetails(
      {required this.id,
      required this.name,
      required this.order,
      required this.officialArtworkSprite,
      required this.stats,
      required this.types});

  factory PokemonDetails.fromJson(Map<String, dynamic> json) {
    var statsList = json['stats'] as List;
    List<PokemonStat> pokemonStats =
        statsList.map((e) => PokemonStat.fromJson(e)).toList();
    var typesList = json['types'] as List;
    List<PokemonType> pokemonTypes =
        typesList.map((e) => PokemonType.fromJson(e)).toList();

    return PokemonDetails(
        id: json['id'],
        name: json['name'],
        order: json['order'],
        officialArtworkSprite: json['sprites']['other']['official-artwork']
            ['front_default'],
        stats: pokemonStats,
        types: pokemonTypes);
  }
}

class PokemonStat {
  String name;
  int baseStats;

  PokemonStat({required this.name, required this.baseStats});

  factory PokemonStat.fromJson(Map<String, dynamic> json) {
    return PokemonStat(
      name: json['stat']['name'],
      baseStats: json['base_stat'],
    );
  }
}

class PokemonType {
  String name;

  PokemonType({required this.name});

  factory PokemonType.fromJson(Map<String, dynamic> json) {
    return PokemonType(
      name: json['type']['name'],
    );
  }
}

// // pokemon_combined_model.dart
// import 'package:pokemon_autoroute/model/pkmn_details.dart';

// class PokemonResults {
//   List<Pokemon> pokemonList;

//   PokemonResults({required this.pokemonList});

//   factory PokemonResults.fromJson(Map<String, dynamic> json) {
//     var resultsList = json['results'] as List;
//     List<Pokemon> pokemonList =
//         resultsList.map((e) => Pokemon.fromJson(e)).toList();

//     return PokemonResults(
//       pokemonList: pokemonList,
//     );
//   }
//   void setSpecificPokemonDetails(List<Pokemon> details) {
//     pokemonList = details;
//   }
// }

// class Pokemon {
//   String name;
//   String url;
//   PokemonDetails details;

//   PokemonDetails get detail => details;

//   Pokemon({required this.name, required this.url, required this.details});

//   factory Pokemon.fromJson(Map<String, dynamic> json) {
//     return Pokemon(
//       name: json['name'],
//       url: json['url'],
//       details: PokemonDetails.fromJson(json['details']),
//     );
//   }
//   int get id => details.id;
//   String get detailName => details.name;
//   String get officialArtworkSprite => details.officialArtworkSprite;
//   List<PokemonStat> get stats => details.stats;
//   List<PokemonType> get types => details.types;
// }

// class PokemonDetails {
//   int id;
//   String name;
//   String officialArtworkSprite;
//   List<PokemonStat> stats;
//   List<PokemonType> types;

//   PokemonDetails(
//       {required this.id,
//       required this.name,
//       required this.officialArtworkSprite,
//       required this.stats,
//       required this.types});

//   factory PokemonDetails.fromJson(Map<String, dynamic> json) {
//     var statsList = json['stats'] as List;
//     List<PokemonStat> pokemonStats =
//         statsList.map((e) => PokemonStat.fromJson(e)).toList();

//     var typesList = json['types'] as List;
//     List<PokemonType> pokemonTypes =
//         typesList.map((e) => PokemonType.fromJson(e)).toList();

//     return PokemonDetails(
//       id: json['id'],
//       name: json['name'],
//       officialArtworkSprite: json['sprites']['other']['official-artwork']
//           ['front_default'],
//       stats: pokemonStats,
//       types: pokemonTypes,
//     );
//   }
// }

// class PokemonStat {
//   String name;
//   int baseStat;

//   PokemonStat({required this.name, required this.baseStat});

//   factory PokemonStat.fromJson(Map<String, dynamic> json) {
//     return PokemonStat(
//       name: json['stat']['name'],
//       baseStat: json['base_stat'],
//     );
//   }
// }

// class PokemonType {
//   String name;

//   PokemonType({required this.name});

//   factory PokemonType.fromJson(Map<String, dynamic> json) {
//     return PokemonType(
//       name: json['type']['name'],
//     );
//   }
// }
