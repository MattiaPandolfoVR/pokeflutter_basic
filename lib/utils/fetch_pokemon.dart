import 'package:http/http.dart' as http;
import 'dart:convert';

//import 'package:pokemon_autoroute/model/pkmn.dart';
import 'package:pokemon_autoroute/model/pkmn_details.dart';

const pokeApidomain = 'pokeapi.co';

// Future<List<PokemonResults>> fetchPokemonsList(int pageIndex) async {
//   final response = await http.get(Uri.https(pokeApidomain, '/api/v2/pokemon',
//       {'limit': '20', 'offset': (pageIndex * 20).toString()}));
//   if (response.statusCode == 200) {
//     final PokemonResult = PokemonResults.fromJson(jsonDecode(response.body))
//         as List<PokemonResults>;
//     final response2 = await http.get(Uri.https(
//         pokeApidomain, '/api/v2/pokemon/${jsonDecode(response.body)['name']}'));
//     if (response.statusCode == 200) {
//       PokemonResult.addAll(json.decode(response2.body)['sprites']);
//     }
//     print(PokemonResult);
//     return PokemonResult;
//     // final List results = json.decode(response.body)['results'];
//     // final List<PokemonResults> newPokemonResult =
//     //     results.map((p) => PokemonResults.fromJson(p)).toList();
//     // return newPokemonResult;
//   } else {
//     throw Exception('Failed to load the data');
//   }
// }

Future<PokemonDetails> fetchPokemonDetails(String id) async {
  final response =
      await http.get(Uri.https(pokeApidomain, '/api/v2/pokemon/$id'));
  if (response.statusCode == 200) {
    return PokemonDetails.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load the data');
  }
}
