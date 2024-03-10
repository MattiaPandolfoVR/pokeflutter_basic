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
