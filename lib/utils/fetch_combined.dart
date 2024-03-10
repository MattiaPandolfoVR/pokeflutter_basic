// /* Questo funziona con future builder e list view*/

// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:pokemon_autoroute/model/pkmn.dart';

// const pokeApidomain = 'pokeapi.co';

// Future<List<PokemonResults>> fetchPokemon(
//     int limit, int pageIndex, List<PokemonResults> combinedDataList) async {
//   final pokemonListResponse = await http.get(Uri.https(
//       pokeApidomain,
//       '/api/v2/pokemon',
//       {'limit': limit.toString(), 'offset': (pageIndex * limit).toString()}));
//   if (pokemonListResponse.statusCode == 200) {
//     final pokemonListJson = json.decode(pokemonListResponse.body);
//     for (var pokemonJson in pokemonListJson['results']) {
//       PokemonResults combinedData = PokemonResults.fromJson({
//         'results': [pokemonJson]
//       });
//       final specificPokemonResponse =
//           await http.get(Uri.parse(pokemonJson['url']));
//       if (specificPokemonResponse.statusCode == 200) {
//         final specificPokemonJson = json.decode(specificPokemonResponse.body);
//         PokemonDetails specificPokemon =
//             PokemonDetails.fromJson(specificPokemonJson);
//         print(specificPokemon);
//         combinedData.setSpecificPokemonDetails(specificPokemon);
//         combinedDataList.add(combinedData);
//       } else {
//         throw Exception('Failed to load the pokemon details');
//       }
//     }
//     return combinedDataList;
//   } else {
//     throw Exception('Failed to load the pokemon data');
//   }
// }

/* Questo funziona con solo il listview builder*/

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pokemon_autoroute/model/pkmn.dart';

class ApiService {
  var pokeApidomain = 'pokeapi.co';

  Future<List<PokemonResults>?> fetchPokemon(
      int limit, int pageIndex, List<PokemonResults>? combinedDataList) async {
    try {
      final pokemonListResponse = await http.get(Uri.https(
          pokeApidomain, '/api/v2/pokemon', {
        'limit': limit.toString(),
        'offset': (pageIndex * limit).toString()
      }));
      if (pokemonListResponse.statusCode == 200) {
        final pokemonListJson = json.decode(pokemonListResponse.body);
        for (var pokemonJson in pokemonListJson['results']) {
          PokemonResults combinedData = PokemonResults.fromJson({
            'results': [pokemonJson]
          });
          final specificPokemonResponse =
              await http.get(Uri.parse(pokemonJson['url']));
          if (specificPokemonResponse.statusCode == 200) {
            final specificPokemonJson =
                json.decode(specificPokemonResponse.body);
            PokemonDetails specificPokemon =
                PokemonDetails.fromJson(specificPokemonJson);
            combinedData.setSpecificPokemonDetails(specificPokemon);
            combinedDataList?.add(combinedData);
          } else {
            throw Exception('Failed to load the pokemon details');
          }
        }
      } else {
        throw Exception('Failed to load the pokemon data');
      }
    } catch (e) {
      throw ('There was an error: $e');
    }
    return combinedDataList;
  }
}

























// // fetch_combined.dart
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:pokemon_autoroute/model/pkmn.dart';

// const pokeApidomain = 'pokeapi.co';

// Future<List<PokemonResults>> fetchPokemon(
//     int limit, int pageIndex, List<PokemonResults> combinedDataList) async {
//   final combinedDataResponse = await http.get(Uri.https(
//       pokeApidomain,
//       '/api/v2/pokemon',
//       {'limit': limit.toString(), 'offset': (pageIndex * limit).toString()}));
//   final combinedDataJson = json.decode(combinedDataResponse.body);

//   var resultsList = combinedDataJson['results'] as List;
//   List<PokemonResults> combinedDataList = [];

//   for (var pokemonJson in resultsList) {
//     final detailsResponse = await http.get(Uri.parse(pokemonJson['url']));
//     final detailsJson = json.decode(detailsResponse.body);
//     PokemonDetails details = PokemonDetails.fromJson(detailsJson);

//     combinedDataList.add(PokemonResults(pokemonList: [
//       Pokemon(
//         name: pokemonJson['name'],
//         url: pokemonJson['url'],
//         details: details,
//       )
//     ]));
//   }

//   return combinedDataList;
//}